//
//  MoviesDetailViewController.swift
//  BoxOffice
//
//  Created by channy on 2022/10/22.
//

import UIKit

class MoviesDetailViewController: UIViewController {
    
    var viewModel: MoviesDetailItemViewModel?
    var repository: MoviesRepository?
    
    lazy var moviesDetailTableView = MoviesDetailTableView()
    
    init(viewModel: MoviesDetailItemViewModel, repository: MoviesRepository) {
        self.viewModel = viewModel
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.moviesDetailTableView.delegate = self
        self.moviesDetailTableView.dataSource = self
        
        fetchMovie()
        setupViews()
        setupConstraints()
        bind()
        setNavigationbar()
    }
    
}

extension MoviesDetailViewController {
    func setupViews() {
        let views = [moviesDetailTableView]
        views.forEach { self.view.addSubview($0) }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.moviesDetailTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.moviesDetailTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.moviesDetailTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.moviesDetailTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func bind() {
        
    }
    
    func setNavigationbar() {
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
}

extension MoviesDetailViewController {
    func fetchMovie() {
        self.repository?.fetchMoviesDetail(movieId: self.viewModel?.movieCd ?? "", completion: { response in
            switch response {
            case .success(let movieDetail):
                self.viewModel?.prdtYear = movieDetail.prdtYear
                self.viewModel?.showTm = movieDetail.showTm
                self.viewModel?.genreNm = movieDetail.genreNm
                self.viewModel?.directorsNm = movieDetail.directorsNm
                self.viewModel?.actorsNm = movieDetail.actorsNm
                self.viewModel?.watchGradeNm = movieDetail.watchGradeNm
                
                DispatchQueue.main.async {
                    self.moviesDetailTableView.reloadData()
                }
                
            case .failure(_):
                print("FETCH ERROR")
            }
        })
    }
}

extension MoviesDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FirstTableViewCell.identifier, for: indexPath) as? FirstTableViewCell else {
                return UITableViewCell()
            }
            
            cell.fill(viewModel: self.viewModel!)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondTableViewCell.identifier, for: indexPath) as? SecondTableViewCell else {
                return UITableViewCell()
            }
            
            cell.fill(viewModel: self.viewModel!)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ThirdTableViewCell.identifier, for: indexPath) as? ThirdTableViewCell else {
                return UITableViewCell()
            }
            
            cell.fill(viewModel: self.viewModel!)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
