//
//  MoviesListViewController.swift
//  BoxOffice
//
//  Created by channy on 2022/10/19.
//

import UIKit

class MoviesListViewController: UIViewController {
    var viewModel: MoviesListViewModel?
    var repository: MoviesRepository?
    
    lazy var moviesListTableView = MoviesListTableView()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.color = .darkGray
        view.startAnimating()
        
        return view
    }()

    init(viewModel: MoviesListViewModel, repository: MoviesRepository) {
        self.viewModel = viewModel
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.moviesListTableView.delegate = self
        self.moviesListTableView.dataSource = self
        
        fetchMovies()
        setupViews()
        setupConstraints()
        bind()
        setNavigationbar()
    }
    
}

extension MoviesListViewController {
    func setupViews() {
        let views = [moviesListTableView, activityIndicatorView]
        views.forEach { self.view.addSubview($0) }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.moviesListTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.moviesListTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.moviesListTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.moviesListTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.activityIndicatorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.activityIndicatorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.activityIndicatorView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.activityIndicatorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    func bind() {
    }
    
    func setNavigationbar() {
        if #available(iOS 15, *) {
            let barAppearance = UINavigationBarAppearance()
            barAppearance.backgroundColor = .white
            barAppearance.titleTextAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .heavy)
            ]
            self.navigationItem.standardAppearance = barAppearance
            self.navigationItem.scrollEdgeAppearance = barAppearance
        } else {
            self.navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .heavy)
            ]
        }
        
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = "Box Office"
    }
}

extension MoviesListViewController {
    func fetchMovies() {
        self.repository?.fetchMoviesList(completion: { response in
            switch response {
            case .success(let movieList):
                self.viewModel?.items = Observable(movieList.map({
                    MoviesListItemViewModel(rank: $0.rank, movieNm: $0.movieNm, openDt: $0.openDt, audiAcc: $0.audiAcc, rankInten: $0.rankInten, rankOldAndNew: $0.rankOldAndNew, movieCd: $0.movieCd)
                }))
               
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                    self.activityIndicatorView.isHidden = true
                    self.moviesListTableView.reloadData()
                }
            case .failure(_):
                print("FETCH ERROR")
            }
        })
    }
}

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.items.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesListTableViewCell.identifier, for: indexPath) as? MoviesListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.fill(viewModel: self.viewModel!.items.value[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = self.viewModel?.items.value[indexPath.row] else { return }
        let moviesDetailViewModel = MoviesDetailItemViewModel(rank: viewModel.rank, movieNm: viewModel.movieNm, openDt: viewModel.openDt, audiAcc: viewModel.audiAcc, rankInten: viewModel.rankInten, rankOldAndNew: viewModel.rankOldAndNew, movieCd: viewModel.movieCd)
        let vc = MoviesDetailViewController(viewModel: moviesDetailViewModel, repository: repository!)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
