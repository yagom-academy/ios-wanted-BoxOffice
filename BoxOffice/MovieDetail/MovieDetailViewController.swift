//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by Julia on 2022/10/18.
//

import UIKit
import SwiftUI

final class MovieDetailViewController: UIViewController {
    
    private let boxOfficeRank: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        label.text = "1"
        return label
    }()
    
    private let rankOldAndNewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.text = "NEW"
        label.textColor = .systemBlue
        label.numberOfLines = 0
        return label
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "극장판 짱구는 못말려: 수수께끼! 꽃피는 천하떡잎학교"
        label.numberOfLines = 0
        return label
    }()
    
    private let movieTitleEngAndproductYearLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.text = "Orphan: First Kill, 2022/01/23"
        label.numberOfLines = 0
        return label
    }()
    
    private let movieOpenDateAndShowTime: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.text = "개봉일, 상영시간"
        label.numberOfLines = 0
        return label
    }()
    
    private let mainInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.backgroundColor = .systemGray6
        return stackView
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let movieDetailTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 50
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private let reviewTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 50
        return tableView
    }()
    
    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .lightGray
        return indicator
    }()
    
    let viewModel: MovieDetailViewModel = .init()
    private let coredataManager = CoreDataManager.shared
    private(set) var inputPassword: String = ""
    private(set) var movieID: String = ""
    private var reviewList: [Review] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        self.settingNavigation()
        self.setupLayouts()
        self.setupViewModel()
        self.configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reviewList = coredataManager.fetchReviews(movieID: movieID)
        self.reviewTableView.reloadData()
    }
    
    private func setupViewModel() {
        // TODO: 인디케이터 동작 안함
        self.viewModel.loadingStart = { [weak self] in
            print("로딩시작")
            self?.indicator.startAnimating()
        }
        
        self.viewModel.updateMovieDetail = { [weak self] model in
            self?.boxOfficeRank.text = model.rank
            self?.movieTitleLabel.text = model.movieName
            self?.movieTitleEngAndproductYearLabel.text = "\(model.movieNameEng), \(model.productYear)"
            self?.movieOpenDateAndShowTime.text = "\(model.openDate), \(model.showTime)"
            self?.movieID = model.movieCode
        }
        
        self.viewModel.loadingEnd = { [weak self] in
            self?.movieDetailTableView.reloadData()
            self?.indicator.stopAnimating()
        }
    }
    
    private func configureTableView() {
        movieDetailTableView.register(MovieDetailCell.self, forCellReuseIdentifier: MovieDetailCell.identifier)
        movieDetailTableView.dataSource = self
        reviewTableView.register(MovieReviewCell.self, forCellReuseIdentifier: MovieReviewCell.identifier)
        reviewTableView.dataSource = self
        reviewTableView.delegate = self
    }
    
    private func settingNavigation() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(writeReview))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc func writeReview() {
        let reviewVC = MovieReviewViewController()
        reviewVC.movieTitle = self.movieTitleLabel.text ?? ""
        reviewVC.movieID  = self.movieID
        print("🎉", movieID)
        self.navigationController?.pushViewController(reviewVC, animated: true)
    }
    
    private func setupLayouts() {
        
        [boxOfficeRank,rankOldAndNewLabel,movieTitleLabel,movieTitleEngAndproductYearLabel,movieOpenDateAndShowTime].forEach {
            self.mainInfoStackView.addArrangedSubview($0)
        }
        
        self.view.addSubViewsAndtranslatesFalse(
            mainInfoStackView,lineView,movieDetailTableView,reviewTableView,indicator
        )
        
        
        NSLayoutConstraint.activate([
            self.mainInfoStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.mainInfoStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            self.mainInfoStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -50)
        ])
        
        // TODO: 라인뷰 안보임
        NSLayoutConstraint.activate([
            self.lineView.topAnchor.constraint(equalTo: self.mainInfoStackView.bottomAnchor, constant: 20),
            self.lineView.heightAnchor.constraint(equalToConstant: 1),
            self.lineView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.lineView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.movieDetailTableView.topAnchor.constraint(equalTo: self.lineView.topAnchor),
            self.movieDetailTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.movieDetailTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.movieDetailTableView.heightAnchor.constraint(equalToConstant: 320)
        ])
        
        NSLayoutConstraint.activate([
            self.reviewTableView.topAnchor.constraint(equalTo: self.movieDetailTableView.bottomAnchor),
            self.reviewTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.reviewTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.reviewTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            indicator.widthAnchor.constraint(equalToConstant: 40),
            indicator.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        self.view.bringSubviewToFront(self.indicator)
        
    }
    
    
}

extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == movieDetailTableView {
            return viewModel.detailTitleList.count
        } else if tableView == reviewTableView {
            return reviewList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == movieDetailTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailCell.identifier, for: indexPath) as? MovieDetailCell else { fatalError("\(MovieDetailCell.identifier) can not dequeue cell") }
            cell.configure(title: viewModel.detailTitleList[indexPath.row],
                           model: viewModel.movieDetailModel)
            return cell
        } else if tableView == reviewTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieReviewCell.identifier, for: indexPath) as? MovieReviewCell else { fatalError("\(MovieReviewCell.identifier) can not dequeue cell") }
            cell.configure(reviewList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    //section
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == movieDetailTableView {
            return "🎞 영화정보"
        } else if tableView == reviewTableView {
            return "📝 리뷰"
        }
        return nil
    }
    
}

extension MovieDetailViewController: UITableViewDelegate {
    // TODO: 라벨 크기에 따른 동적 셀 구현해야됨
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alertVC = UIAlertController(title: nil, message: "암호를 입력해주세요.", preferredStyle: .alert)
            //비밀번호 입력 후 맞는지 확인
            let confirm = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
                
            }
            //비밀번호 입력 후 temp에 저장
            alertVC.addTextField { [weak self] textField in
                self?.inputPassword = textField.text ?? ""
                print("😗", textField.text)
            }
            alertVC.addAction(confirm)
            self.present(alertVC, animated: true)
        }
    }
    
}
