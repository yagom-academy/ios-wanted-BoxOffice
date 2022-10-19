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
    }
    
    func fetchData() {
        movieInfoViewModel.fetchAPIData {
            print(self.movieInfoViewModel.cellViewModel)
            self.mainView.movieInfoTableView.reloadData()
            self.setupNavigation()
        }
    }
    
    func setupNavigation() {
        navigationItem.title = "영화 상세정보"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
}

extension MovieInfoViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieInfoViewModel.cellViewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }


}
