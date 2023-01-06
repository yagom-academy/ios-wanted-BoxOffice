//
//  MovieListViewController.swift
//  BoxOffice
//
//  Created by TORI on 2023/01/02.
//

import UIKit

final class MovieListViewController: UIViewController {
    
    enum Section {
        case main
    }

    private typealias DataSource = UITableViewDiffableDataSource<Section, MovieEssentialInfo> // 영화 타입 들어가기
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, MovieEssentialInfo> // 영화 타입 들어가기
    
    private var dataSource: DataSource?
    private var snapshot = Snapshot()
    
    
    private let movieListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        
        return tableView
    }()
    
    private let viewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefault()
        setupSubviews()
        setupLayout()
        appendData()
        setupNavigation()
    }
    
    private func setupDefault() {
        view.backgroundColor = .white
        
        movieListTableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: "MovieListViewCell")
        movieListTableView.delegate = self

        dataSource = DataSource(
            tableView: movieListTableView,
            cellProvider: { tableView, indexPath, itemIdentifier in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: "MovieListViewCell",
                    for: indexPath
                ) as? MovieListTableViewCell else {
                    return nil
                }

                cell.configure(movie: itemIdentifier)
                return cell
            })
        
        snapshot.appendSections([.main])
    }
    
    private func setupSubviews() {
        view.addSubview(movieListTableView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            movieListTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieListTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            movieListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupNavigation() {
        navigationItem.title = "박스오피스 순위"
    }
    
    private func appendData() {
        viewModel.fetch(date: "20221214") { [weak self] (movies) in
            guard let self = self else { return }
            print(movies)
            self.snapshot.appendItems(movies)
            self.dataSource?.apply(self.snapshot)
        }
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
