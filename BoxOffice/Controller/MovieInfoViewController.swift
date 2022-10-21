//
//  DetailViewController.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/19.
//

import UIKit

class MovieInfoViewController: UIViewController {
    
    let mainView = MovieInfoView()
    let movieInfoViewModel: MovieInfoViewModel
    var sectionCount = 0
    
    
    init(dailyBoxOffice: DailyBoxOfficeList) {
        self.movieInfoViewModel = MovieInfoViewModel(dailyBoxOffice: dailyBoxOffice)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        // Do any additional setup after loading the view.
    }
    
    func setup() {
        fetchData()
        mainView.movieInfoTableView.delegate = self
        mainView.movieInfoTableView.dataSource = self
        mainView.movieInfoTableView.register(MovieInfoTableViewCell.self, forCellReuseIdentifier: MovieInfoCellViewModel.identifier)
        mainView.movieInfoTableView.register(StarScoreCell.self, forCellReuseIdentifier: StarScoreCell.identifier)
        mainView.movieInfoTableView.register(ReviewCell.self, forCellReuseIdentifier: ReviewCellViewModel.identifier)
    }
    
    func fetchData() {
        movieInfoViewModel.clearCellViewModel()
        movieInfoViewModel.fetchAPIData {
            self.mainView.movieInfoTableView.reloadData()
            self.setupNavigation()
            
        }
        movieInfoViewModel.requestFireBase {
            self.mainView.movieInfoTableView.reloadData()
        }
    }
    
    func deleteData(indexPath: IndexPath) {
        
        let alert = InputAlert(title: "비밀번호 입력", message: "암호를 입력해주세요", preferredStyle: .alert)
        alert.buttonAction = { password in
            self.movieInfoViewModel.deleteReview(password: password,index: indexPath.row) { result in
                
                if result {
                    let alert = UIAlertController(title: "삭제 완료", message: "리뷰가 삭제 되었습니다", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .cancel))
                    self.present(alert, animated: true)
                    self.fetchData()
                } else {
                    let alert = UIAlertController(title: "삭제 실패", message: "암호가 맞지 않습니다", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .cancel))
                    self.present(alert, animated: true)
                }
            }
        }
        self.present(alert, animated: true)
    }
    
    func setupNavigation() {
        navigationItem.title = "영화 상세정보"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
}

extension MovieInfoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 2 {
            return "리뷰 리스트"
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .black
        header.textLabel?.font = .boldSystemFont(ofSize: 20)
        header.textLabel?.frame = CGRect(x: 20, y: 0, width: 300, height: 30)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.movieInfoViewModel.sectionCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return movieInfoViewModel.reviewCellViewModel.count
        } else {
            return movieInfoViewModel.cellViewModel.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let viewModel = self.movieInfoViewModel.cellViewModel[indexPath.row]
            guard let cell = tableView.dequeueReusableCell(withIdentifier: type(of: viewModel).identifier, for: indexPath) as? MovieInfoTableViewCell
            else {
                return UITableViewCell()
            }
            switch ( cell, viewModel ){
            case let ( cell, viewModel) as (MovieInfoTableViewCell, MovieInfoCellViewModel):
                cell.cellViewModel = viewModel
            default:
                fatalError()
            }
            return cell
            
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StarScoreCell.identifier, for: indexPath) as? StarScoreCell
            else {
                return UITableViewCell()
            }
            cell.starScore.inputScore(score: movieInfoViewModel.averageScore())
            cell.buttonAction = {
                let vc = ReviewViewController(movieName: self.movieInfoViewModel.dailyBoxOffice.movieNm)
                vc.reviewWrite = {
                    self.fetchData()
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
            
        } else {
            let viewModel = self.movieInfoViewModel.reviewCellViewModel[indexPath.row]
            guard let cell = tableView.dequeueReusableCell(withIdentifier: type(of: viewModel).identifier, for: indexPath) as? ReviewCell
            else {
                return UITableViewCell()
            }
            switch ( cell, viewModel ){
            case let ( cell, viewModel) as (ReviewCell, ReviewCellViewModel):
                cell.cellViewModel = viewModel
                cell.deleteButtonAction = {
                    self.deleteData(indexPath: indexPath)
                }
            default:
                fatalError()
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
