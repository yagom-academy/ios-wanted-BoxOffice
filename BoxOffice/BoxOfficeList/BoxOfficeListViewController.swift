//
//  BoxOfficeListViewController.swift
//  BoxOffice
//
//  Created by YunYoungseo on 2023/01/02.
//

import UIKit

class BoxOfficeListViewController: UIViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, BoxOfficeListCellViewModel>
    
    private var dataSource: DataSource? = nil
    private let listView: UICollectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    private let periodSegmentedControl = UISegmentedControl()
    private let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "첫 화면"
        view.backgroundColor = .systemBackground
        setupSegmentControll()
        setupListView()
        layout()
        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, BoxOfficeListCellViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(testDatasForDay)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }

    private func setupSegmentControll() {
        let segment1 = UIAction(title: Period.day.title) { [weak self] _ in
            guard let self = self else { return }
            var snapshot = NSDiffableDataSourceSnapshot<Section, BoxOfficeListCellViewModel>()
            snapshot.appendSections([.main])
            snapshot.appendItems(self.testDatasForDay)
            self.dataSource?.apply(snapshot, animatingDifferences: false)
        }
        periodSegmentedControl.insertSegment(action: segment1, at: 0, animated: false)

        let segment2 = UIAction(title: Period.week.title) { [weak self] _ in
            guard let self = self else { return }
            var snapshot = NSDiffableDataSourceSnapshot<Section, BoxOfficeListCellViewModel>()
            snapshot.appendSections([.main])
            snapshot.appendItems(self.testDatasForWeek)
            self.dataSource?.apply(snapshot, animatingDifferences: false)
        }
        periodSegmentedControl.insertSegment(action: segment2, at: 1, animated: false)

        let segment3 = UIAction(title: Period.weekEnd.title) { [weak self] _ in
            guard let self = self else { return }
            var snapshot = NSDiffableDataSourceSnapshot<Section, BoxOfficeListCellViewModel>()
            snapshot.appendSections([.main])
            snapshot.appendItems(self.testDatasForWeekend)
            self.dataSource?.apply(snapshot, animatingDifferences: false)
        }
        periodSegmentedControl.insertSegment(action: segment3, at: 2, animated: false)

        periodSegmentedControl.selectedSegmentIndex = 0
    }

    private func setupListView() {
        let cellRegistraion = UICollectionView.CellRegistration<BoxOfficeListCell, BoxOfficeListCellViewModel> { cell, indexPath, item in
            cell.viewModel = item
        }

        dataSource = DataSource(collectionView: listView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistraion, for: indexPath, item: item)
        }

        listView.dataSource = dataSource
    }

    private func layout() {
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
        stackView.addArrangedSubview(periodSegmentedControl)
        stackView.addArrangedSubview(listView)
    }
}

extension BoxOfficeListViewController {
    private enum Section: CaseIterable {
        case main
    }

    private enum Period: CaseIterable {
        case day
        case week
        case weekEnd

        var title: String {
            switch self {
            case .day:
                return "일"
            case .week:
                return "주"
            case .weekEnd:
                return "주말"
            }
        }
    }
}

extension BoxOfficeListViewController {
    private var testDatasForDay: [BoxOfficeListCellViewModel] {
        return [
            BoxOfficeListCellViewModel(movieName: "Avatar: The Way of Water",
                                       lank: 1,
                                       openDate: "2022-12-14",
                                       audienceCount: 1,
                                       rankingChange: 1,
                                       isNewEntryToRank: true),
            BoxOfficeListCellViewModel(movieName: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                       lank: 2,
                                       openDate: "",
                                       audienceCount: 12,
                                       rankingChange: 0,
                                       isNewEntryToRank: false)
        ]
    }
    private var testDatasForWeek: [BoxOfficeListCellViewModel] {
        return [
            BoxOfficeListCellViewModel(movieName: "Avatar: The Way of Water",
                                       lank: 1,
                                       openDate: "2022-12-14",
                                       audienceCount: 2,
                                       rankingChange: 1,
                                       isNewEntryToRank: true),
            BoxOfficeListCellViewModel(movieName: "title2",
                                       lank: 3,
                                       openDate: "",
                                       audienceCount: 12,
                                       rankingChange: -3,
                                       isNewEntryToRank: false)
        ]
    }
    private var testDatasForWeekend: [BoxOfficeListCellViewModel] {
        return [
            BoxOfficeListCellViewModel(movieName: "Avatar: The Way of Water",
                                       lank: 1,
                                       openDate: "2022-12-14",
                                       audienceCount: 3,
                                       rankingChange: 1,
                                       isNewEntryToRank: true),
            BoxOfficeListCellViewModel(movieName: "title2",
                                       lank: 2,
                                       openDate: "",
                                       audienceCount: 12,
                                       rankingChange: -2,
                                       isNewEntryToRank: false)
        ]
    }
}
