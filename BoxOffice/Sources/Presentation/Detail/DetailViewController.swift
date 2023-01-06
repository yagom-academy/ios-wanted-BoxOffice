//
//  DetailViewController.swift
//  BoxOffice
//
//  Created by 이예은 on 2023/01/03.
//

import UIKit
import Combine

class MovieDetailViewController: UIViewController {
    
    weak var coordinator: BoxOfficeListCoordinatorInterface?
    private let viewModel: MovieDetailViewModel
    private var cancelable = Set<AnyCancellable>()
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = .boBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        self.view.backgroundColor = .boBackground
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FirstCell.self, forCellReuseIdentifier: "FirstCell")
        tableView.register(SecondCell.self, forCellReuseIdentifier: "SecondCell")
        tableView.register(ThirdCell.self, forCellReuseIdentifier: "ThirdCell")
        tableView.register(ReviewCell.self, forCellReuseIdentifier: "ReviewCell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.input.viewWillAppear()
    }
    
    init(viewModel: MovieDetailViewModel, coordinator: BoxOfficeListCoordinatorInterface) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MovieDetailViewController {
    func bind() {
        viewModel.output.shareMovieInfoPublisher
            .sink { [weak self] sharedInformation in
                guard let self = self else { return }
                let activityController = UIActivityViewController(
                    activityItems: sharedInformation,
                    applicationActivities: nil
                )
                self.present(activityController, animated: true)
            }
            .store(in: &cancelable)
        
        viewModel.output.reviewModel
            .sink { [weak self] reviews in
                guard let self = self else { return }
                
                self.tableView.reloadData()
            }
            .store(in: &cancelable)
        
        viewModel.output.errorMessage
            .compactMap { $0 }
            .sinkOnMainThread(receiveValue: { [weak self] message in
                self?.showAlert(message: message)
            }).store(in: &cancelable)
    }
    
    func setUpReviewButton(_ cell: ThirdCell) {
        cell.reviewButton.addTarget(self, action: #selector(didTapReviewButton(_:)), for: .touchUpInside)
    }
    
    @objc func didTapReviewButton(_ sender: UIButton) {
        coordinator?.showCreateReviewView(movie: viewModel.output.movie)
    }
    
    func setUpDeleteButton(_ cell: ReviewCell) {
        cell.deleteButton.addTarget(self, action: #selector(didTapDeleteButton(_:)), for: .touchUpInside)
    }
    
    @objc func didTapDeleteButton(_ sender: UIButton) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.init(x: 5.0, y: 5.0), to: self.tableView)
        guard let indexPath = self.tableView.indexPathForRow(at: buttonPosition) else {
            return
        }
        
        let alertVC = UIAlertController(title: nil, message: "암호를 입력해주세요.", preferredStyle: .alert)
        
        alertVC.addTextField()
        let textField = alertVC.textFields?.first
        textField?.isSecureTextEntry = true
        
        let confirm = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.input.checkPassword(textField?.text ?? "", index: indexPath.row)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alertVC.addAction(confirm)
        alertVC.addAction(cancel)
        self.present(alertVC, animated: true)
    }
    
    func setUpShareButton(_ cell: FirstCell) {
        cell.shareButton.addTarget(self, action: #selector(didTapShareButton(_:)), for: .touchUpInside)
    }
    
    @objc func didTapShareButton(_ sender: UIButton) {
        viewModel.input.didTapShareButton()
    }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel._reviews.count + 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstCell", for: indexPath) as! FirstCell
            cell.transferData(viewModel._movie.name, viewModel._movie.detailInfo!, viewModel._movie.boxOfficeInfo!)
            setUpShareButton(cell)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath) as! SecondCell
            cell.transferData(viewModel._movie.boxOfficeInfo!, viewModel.review)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdCell", for: indexPath) as! ThirdCell
            setUpReviewButton(cell)
            cell.transferData(viewModel._movie.detailInfo!)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
            
            setUpDeleteButton(cell)
            cell.transferData(viewModel.review, indexPath.row - 3, tableView)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
