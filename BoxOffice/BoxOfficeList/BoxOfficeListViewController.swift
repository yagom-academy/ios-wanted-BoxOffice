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
        segmentedControl.selectedSegmentIndex = 1
        return segmentedControl
    }()
    private let stackView = UIStackView()
    private let testDatas: [BoxOfficeListCellViewModel] = [
        BoxOfficeListCellViewModel(movieName: "Avatar: The Way of Water",
                                   lank: 1,
                                   openDate: "2022-12-14",
                                   audienceCount: 123,
                                   increaseOrDecreaseInRank: 1,
                                   isNewEntryToRank: true),
        BoxOfficeListCellViewModel(movieName: "title2",
                                   lank: 2,
                                   openDate: "",
                                   audienceCount: 12,
                                   increaseOrDecreaseInRank: 0,
                                   isNewEntryToRank: false)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "첫 화면"
        view.backgroundColor = .systemBackground
        setupListView()
        layout()
        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, BoxOfficeListCellViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(testDatas)
        dataSource?.apply(snapshot, animatingDifferences: false)
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
