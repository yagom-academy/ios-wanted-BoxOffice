//
//  HomeCollectionView.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/03.
//

import UIKit

final class HomeCollectionView: UICollectionView {
    
    private enum Section: String, CaseIterable {
        case allWeek = "주간 박스오피스"
        case weekEnd = "주말 박스오피스"
        case main
    }
    var currentDate = ""
    private var currentViewMode: BoxOfficeMode = .daily
    private var homeDataSource: UICollectionViewDiffableDataSource<Section, MovieCellData>?
    private var snapshot = NSDiffableDataSourceSnapshot<Section, MovieCellData>()
    
    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        configureHierachy()
        configureDataSource(with: createDailyCellRegistration())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierachy() {
        frame = bounds
        collectionViewLayout = createDailyLayout()
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func createDailyLayout() -> UICollectionViewLayout {
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
    
    private func createWeeklyLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 5,
            bottom: 0,
            trailing: 5
        )
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(0.5)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
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
  
    private func configureDataSource<T: UICollectionViewCell>(
        with cellRegistration: UICollectionView.CellRegistration<T, MovieCellData>
    ) {
        let headerRegistration = createHeaderRegistration()
        homeDataSource = createDataSource(with: cellRegistration)
        
        homeDataSource?.supplementaryViewProvider = { (view, kind, index) in
            return self.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: index)
        }
        if currentViewMode == .daily {
            snapshot.deleteAllItems()
            snapshot.appendSections([.main])
            homeDataSource?.apply(snapshot, animatingDifferences: false)
        } else {
            snapshot.deleteAllItems()
            snapshot.appendSections([.allWeek, .weekEnd])
            homeDataSource?.apply(snapshot, animatingDifferences: false)
        }
    }
    
    private func createHeaderRegistration() -> UICollectionView.SupplementaryRegistration<HeaderView> {
        let headerRegistration = UICollectionView.SupplementaryRegistration<HeaderView>(elementKind: "headerView") {
            (supplementaryView, elementKind, indexPath) in
            if self.currentViewMode == .daily {
                guard self.currentDate != "" else { return }
                let dateArray = Array(self.currentDate).map { String($0) }
                supplementaryView.sectionHeaderlabel.text = "\(dateArray[0...3].joined())년 \(dateArray[4...5].joined())월 \(dateArray[6...7].joined())일"
            } else {
                supplementaryView.sectionHeaderlabel.text = Section.allCases[indexPath.section].rawValue
            }
        }
        return headerRegistration
    }
    
    private func createDailyCellRegistration() -> UICollectionView.CellRegistration<ListCell, MovieCellData> {
        let cellRegistration = UICollectionView.CellRegistration<ListCell, MovieCellData> { (cell, _, item) in
            cell.setup(with: item)
        }
        return cellRegistration
    }
    
    private func createWeeklyCellRegistration() -> UICollectionView.CellRegistration<GridCell, MovieCellData> {
        let cellRegistration = UICollectionView.CellRegistration<GridCell, MovieCellData> { (cell, _, item) in
            cell.setup(with: item)
        }
        return cellRegistration
    }
    
    private func createDataSource<T: UICollectionViewCell>(
        with cellRegistration: UICollectionView.CellRegistration<T, MovieCellData>
    ) -> UICollectionViewDiffableDataSource<Section, MovieCellData>? {
        let dataSource = UICollectionViewDiffableDataSource<Section, MovieCellData>(collectionView: self) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: MovieCellData) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        return dataSource
    }
    
    private func switchLayout(to mode: BoxOfficeMode) {
        if mode == .daily {
            setCollectionViewLayout(createDailyLayout(), animated: false)
        } else {
            setCollectionViewLayout(createWeeklyLayout(), animated: false)
        }
    }
    
    func appendDailySnapshot(with cellDatas: [MovieCellData]) {
        snapshot.deleteAllItems() 
        snapshot.appendSections([.main])
        snapshot.appendItems(cellDatas)
        homeDataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    func appendAllWeekSnapshot(data: [MovieCellData]) {
        snapshot.deleteSections([.allWeek])
        snapshot.appendSections([.allWeek])
        snapshot.appendItems(data, toSection: .allWeek)
        homeDataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    func appendWeekEndSnapshot(data: [MovieCellData]) {
        snapshot.deleteSections([.weekEnd])
        snapshot.appendSections([.weekEnd])
        snapshot.appendItems(data, toSection: .weekEnd)
        homeDataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    func switchMode(_ mode: BoxOfficeMode){
        if mode == .daily {
            switchLayout(to: .daily)
            currentViewMode = .daily
            configureDataSource(with: createDailyCellRegistration())
        } else {
            switchLayout(to: .weekly)
            currentViewMode = .weekly
            configureDataSource(with: createWeeklyCellRegistration())
        }
    }
}
