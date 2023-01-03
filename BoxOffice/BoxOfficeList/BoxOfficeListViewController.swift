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

    private let periodSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        ["일별", "주간", "주말"].enumerated().forEach { index, mode in
            segmentedControl.insertSegment(withTitle: mode, at: index, animated: false)
        }
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    private let stackView = UIStackView()
    private let testDatasForDay: [BoxOfficeListCellViewModel] = [
        BoxOfficeListCellViewModel(movieName: "Avatar: The Way of Water",
                                   lank: 1,
                                   openDate: "2022-12-14",
                                   audienceCount: 1,
                                   increaseOrDecreaseInRank: 1,
                                   isNewEntryToRank: true),
        BoxOfficeListCellViewModel(movieName: "title2",
                                   lank: 2,
                                   openDate: "",
                                   audienceCount: 12,
                                   increaseOrDecreaseInRank: 0,
                                   isNewEntryToRank: false)
    ]
    private let testDatasForWeek: [BoxOfficeListCellViewModel] = [
        BoxOfficeListCellViewModel(movieName: "Avatar: The Way of Water",
                                   lank: 1,
                                   openDate: "2022-12-14",
                                   audienceCount: 2,
                                   increaseOrDecreaseInRank: 1,
                                   isNewEntryToRank: true),
        BoxOfficeListCellViewModel(movieName: "title2",
                                   lank: 2,
                                   openDate: "",
                                   audienceCount: 12,
                                   increaseOrDecreaseInRank: 0,
                                   isNewEntryToRank: false)
    ]
    private let testDatasForWeekend: [BoxOfficeListCellViewModel] = [
        BoxOfficeListCellViewModel(movieName: "Avatar: The Way of Water",
                                   lank: 1,
                                   openDate: "2022-12-14",
                                   audienceCount: 3,
                                   increaseOrDecreaseInRank: 1,
                                   isNewEntryToRank: true),
        BoxOfficeListCellViewModel(movieName: "title2",
                                   lank: 2,
                                   openDate: "",
                                   audienceCount: 12,
                                   increaseOrDecreaseInRank: -2,
                                   isNewEntryToRank: false)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "첫 화면"
        view.backgroundColor = .systemBackground
        setupListView()
        layout()
        setupSegmentControll()
        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, BoxOfficeListCellViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(testDatasForDay)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }

    private func setupSegmentControll() {
        let segment1 = UIAction(title: "일별") { [weak self] _ in
            guard let self = self else { return }
            var snapshot = NSDiffableDataSourceSnapshot<Section, BoxOfficeListCellViewModel>()
            snapshot.appendSections([.main])
            snapshot.appendItems(self.testDatasForDay)
            self.dataSource?.apply(snapshot, animatingDifferences: false)
        }
        periodSegmentedControl.setAction(segment1, forSegmentAt: 0)

        let segment2 = UIAction(title: "주간") { [weak self] _ in
            guard let self = self else { return }
            var snapshot = NSDiffableDataSourceSnapshot<Section, BoxOfficeListCellViewModel>()
            snapshot.appendSections([.main])
            snapshot.appendItems(self.testDatasForWeek)
            self.dataSource?.apply(snapshot, animatingDifferences: false)
        }
        periodSegmentedControl.setAction(segment2, forSegmentAt: 1)

        let segment3 = UIAction(title: "주말") { [weak self] _ in
            guard let self = self else { return }
            var snapshot = NSDiffableDataSourceSnapshot<Section, BoxOfficeListCellViewModel>()
            snapshot.appendSections([.main])
            snapshot.appendItems(self.testDatasForWeekend)
            self.dataSource?.apply(snapshot, animatingDifferences: false)
        }
        periodSegmentedControl.setAction(segment3, forSegmentAt: 2)
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
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        stackView.addArrangedSubview(periodSegmentedControl)
        stackView.addArrangedSubview(listView)
    }
}

extension BoxOfficeListViewController {
    private enum Section: CaseIterable {
        case main
    }
}
