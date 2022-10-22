//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

final class MovieListViewController: UIViewController {
    
    private let movieListTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .systemGray6
        tableView.rowHeight = 100
        return tableView
    }()
    
    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .lightGray
        return indicator
    }()
    
    private let viewModel: MovieListViewModel = .init()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.settingNavigation()
        self.setupLayouts()
        self.configure(movieListTableView)
        self.setupViewModel()
        
    }
    
    private func settingNavigation() {
        self.navigationItem.title = "🎥어제의 영화순위"
    }
    
    private func setupViewModel() {
        self.viewModel.loadingStart = { [weak self] in
            self?.indicator.startAnimating()
        }
        
        self.viewModel.updateMovieList = { [weak self] in
            self?.movieListTableView.reloadData()
        }
        
        self.viewModel.loadingEnd = { [weak self] in
            self?.indicator.stopAnimating()
        }
        self.viewModel.requestMovieList()
        print("🍎 \(viewModel.movieList)")
    }
    
    // MARK: - Private func
    private func setupLayouts() {
        self.view.addSubViewsAndtranslatesFalse(movieListTableView,
                                                indicator)
        NSLayoutConstraint.activate([
            movieListTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            movieListTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            movieListTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            movieListTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            indicator.widthAnchor.constraint(equalToConstant: 40),
            indicator.heightAnchor.constraint(equalToConstant: 40)
        ])
        self.view.bringSubviewToFront(self.indicator)
        
    }
    
    private func configure(_ tableView: UITableView) {
        tableView.register(MovieListCell.self, forCellReuseIdentifier: MovieListCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getMovieListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.identifier, for: indexPath) as? MovieListCell else { fatalError("\(MovieListCell.identifier) can not dequeue cell")  }
        cell.configure(viewModel.movieList[indexPath.row])
        return cell
    }
    
}

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieDetailViewController()
        vc.viewModel.movieListModel = viewModel.movieList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

