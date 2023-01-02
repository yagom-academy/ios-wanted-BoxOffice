//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

final class MovieListViewController: UIViewController {
    private let viewModel = MovieListViewModel()

    private lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl()
        let daySegmentSelected: ((UIAction) -> Void) = { [weak self] _ in
            self?.viewModel.dayTypeSegmentValueChanged(value: .day)
        }
        let weekendSegmentSelected: ((UIAction) -> Void) = { [weak self] _ in
            self?.viewModel.dayTypeSegmentValueChanged(value: .weekDaysAndWeekend)
        }
        segmentControl.setAction(UIAction(handler: daySegmentSelected), forSegmentAt: 0)
        segmentControl.setAction(UIAction(handler: weekendSegmentSelected), forSegmentAt: 1)
        return segmentControl
    }()

    private lazy var movieListTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.viewDidLoad()
    }

    private func bind() {
        viewModel.applySnapShot = {
            self.movieListTableView.reloadData()
        }
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.movieOverviewList.count - 1 {
            viewModel.scrollEnded()
        }
    }
}

extension MovieListViewController {
    enum Section {
        case main
    }
}
