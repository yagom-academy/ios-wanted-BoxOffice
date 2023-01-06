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
    
    private lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: [FetchType.today.value, FetchType.week.value])
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 0
        
        return control
    }()
    
    private var lastWeek: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let timeInterval = Date().timeIntervalSince1970 - (86400 * 7)
        let date = Date(timeIntervalSince1970: timeInterval)
        return formatter.string(from: date)
    }
    
    private var today: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let timeInterval = Date().timeIntervalSince1970 - 86400
        let date = Date(timeIntervalSince1970: timeInterval)
        return formatter.string(from: date)
    }
    
    private let viewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
        setupDefault()
        setupSubviews()
        setupLayout()
        setupNavigation()
        bind()
    }
    
    private func bind() {
        viewModel.fetchBoxOffice(date: today)
    }
    
    private func setupDataSource() {
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
    
    private func setupDefault() {
        view.backgroundColor = .white
        segmentedControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        appendDailyData()
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
        navigationItem.titleView?.largeContentTitle = "박스오피스 순위"
        navigationItem.titleView = segmentedControl
    }
    
    @objc private func fetchData() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            appendDailyData()
        case 1:
            appendWeekData()
        default:
            return
        }
    }
    
    private func appendDailyData() {
        snapshot.deleteAllItems()
        snapshot.appendSections([.main])
        viewModel.movieEssentialInfoList.subscribe { (movies: [MovieEssentialInfo]) in
            DispatchQueue.main.async {
                self.snapshot.appendItems(movies)
                self.dataSource?.apply(self.snapshot)
            }
        }
    }
    
    private func appendWeekData() {
        snapshot.deleteAllItems()
        snapshot.appendSections([.main])
        viewModel.movieEssentialInfoList.subscribe { (movies: [MovieEssentialInfo]) in
            self.snapshot.appendItems(movies)
            self.dataSource?.apply(self.snapshot)
        }
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = MovieDetailViewController()
        let movie = snapshot.itemIdentifiers[indexPath.row]
        detailView.configure(movie)
        navigationController?.pushViewController(detailView, animated: true)
    }
}

enum FetchType {
    case today
    case week
    
    var number: Int {
        switch self {
        case .today:
            return 0
        case .week:
            return 1
        }
    }
    
    var value: String {
        switch self {
        case .today:
            return "Today"
        case .week:
            return "Week"
        }
    }
}
