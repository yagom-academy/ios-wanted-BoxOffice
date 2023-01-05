//
//  HomeCollectionView.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/03.
//

import UIKit

final class HomeCollectionView: UICollectionView {
    
    private enum Section {
        case main
        case weekdays
        case allWeek
    }
    
    var currentDate = ""
    private var homeDataSource: UICollectionViewDiffableDataSource<Section, MovieCellData>?
    private var snapshot = NSDiffableDataSourceSnapshot<Section, MovieCellData>()
    
    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        configureHierachy()
        configureDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierachy() {
        frame = bounds
        collectionViewLayout = createListLayout()
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func createListLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 10,
            bottom: 0,
            trailing: 10
        )
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.25)
        )        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        let headerFooterSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: "headerView",
            alignment: .top
        )
        section.boundarySupplementaryItems = [sectionHeader]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
  
    private func configureDataSource() {
        let headerRegistration = generateHeaderRegistration()
        let cellRegistration = generateCellRegistration()
        homeDataSource = generateDataSource(with: cellRegistration)
        
        homeDataSource?.supplementaryViewProvider = { (view, kind, index) in
            return self.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: index)
        }
        snapshot.appendSections([.main])
        homeDataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    private func generateHeaderRegistration() -> UICollectionView.SupplementaryRegistration<HeaderView> {
        let headerRegistration = UICollectionView.SupplementaryRegistration<HeaderView>(elementKind: "headerView") {
            (supplementaryView, elementKind, indexPath) in
            
            guard self.currentDate != "" else { return }
            let dateArray = Array(self.currentDate).map { String($0) }
            supplementaryView.label.text = "\(dateArray[0...3].joined())년 \(dateArray[4...5].joined())월 \(dateArray[6...7].joined())일"
        }
        return headerRegistration
    }
    
    private func generateCellRegistration() -> UICollectionView.CellRegistration<ListCell, MovieCellData> {
        let cellRegistration = UICollectionView.CellRegistration<ListCell, MovieCellData> { (cell, _, item) in
            cell.setup(with: item)
        }
        return cellRegistration
    }
    
    private func generateDataSource(
        with cellRegistration: UICollectionView.CellRegistration<ListCell, MovieCellData>
    ) -> UICollectionViewDiffableDataSource<Section, MovieCellData>? {
        let dataSource = UICollectionViewDiffableDataSource<Section, MovieCellData>(collectionView: self) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: MovieCellData) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: itemIdentifier
            )
        }
        return dataSource
    }
    
    func appendSnapshot(with cellDatas: [MovieCellData]) {
        snapshot.deleteAllItems()
        snapshot.appendSections([.main])
        snapshot.appendItems(cellDatas)
        homeDataSource?.apply(snapshot, animatingDifferences: false)
    }
}
