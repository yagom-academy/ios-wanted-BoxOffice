//
//  DetailViewController.swift
//  BoxOffice
//
//  Created by sole on 2022/10/18.
//

import UIKit

final class DetailViewController: UIViewController {
    private var dataSource: UICollectionViewDiffableDataSource<DetailSection, DetailItem>!
    var detailItems = [DetailItem]()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
//        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        return collectionView
    }()
    
    private var floatingView: FloatingView = {
        let view = FloatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureDataSource()
    }
    
    private func configureHierarchy() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        view.addSubview(floatingView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            floatingView.widthAnchor.constraint(equalToConstant: 200),
            floatingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            floatingView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130)
        ])
    }
}

/// - Tag: Layout
extension DetailViewController {
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            let section = DetailSection(rawValue: sectionIndex)!
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .absolute(40))
            let textHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                         elementKind: TextHeaderView.elementKind,
                                                                         alignment: .top)
            textHeader.pinToVisibleBounds = true
            
            let defaultSpacing = CGFloat(15)
            let bottomSpacing = CGFloat(30)
            let estimatedHeight = CGFloat(100)
            
            switch section {
            // trailer section layout
            case .main:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalWidth(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize,
                                                               subitem: item,
                                                               count: 1)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: bottomSpacing, trailing: 0)
                return section
                
            // plot, detail section layout
            // TODO: - estimated가 적용되지 않음
            case .plot, .detail:
                let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .estimated(estimatedHeight))
                let item = NSCollectionLayoutItem(layoutSize: layoutSize)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: layoutSize,
                                                             subitem: item,
                                                             count: 1)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: defaultSpacing, bottom: defaultSpacing, trailing: defaultSpacing)
                section.boundarySupplementaryItems = [textHeader]
                return section
            }
        }
        return layout
    }
}

extension DetailViewController {
    private func configureDataSource() {
        /// - Tag: Registration
        let textHeaderRegistration = UICollectionView.SupplementaryRegistration<TextHeaderView>(supplementaryNib: TextHeaderView.nib(), elementKind: TextHeaderView.elementKind) { textHeaderView, _, indexPath in
            guard let section = DetailSection(rawValue: indexPath.section),
                  section != .main,
                  let title = section.title else { return }
            textHeaderView.configure(title: title)
        }

        let trailerCellRegistration = UICollectionView.CellRegistration<TrailerCell, MainInformation>(cellNib: TrailerCell.nib()) { cell, _, mainitem in
            if mainitem.backdropPath == nil,
               mainitem.posterPath == nil,
               mainitem.id == nil {
                cell.playImageView.image = UIImage(systemName: "play.slash")
            }
            cell.configure(with: mainitem)
        }
        
        let plotCellRegistration = UICollectionView.CellRegistration<PlotCell, Plot>(cellNib: PlotCell.nib()) { cell, _, plot in
            cell.appearanceLabel(isOpend: plot.isOpend)
            cell.configure(with: plot)
        }
       
        let detailCellRegistration = UICollectionView.CellRegistration<DetailInformationCell, DetailInformation>(cellNib: DetailInformationCell.nib()) { cell, _, detailitem in
            cell.configure(with: detailitem)
        }

        /// - Tag: DataSource
        dataSource = UICollectionViewDiffableDataSource<DetailSection, DetailItem>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            switch item {
            case .main(let mainItem):
                return collectionView.dequeueConfiguredReusableCell(using: trailerCellRegistration, for: indexPath, item: mainItem)
            case .plot(let plot):
                return collectionView.dequeueConfiguredReusableCell(using: plotCellRegistration, for: indexPath, item: plot)
            case .detail(let detailItem):
                return collectionView.dequeueConfiguredReusableCell(using: detailCellRegistration, for: indexPath, item: detailItem)
            }
        })

        dataSource.supplementaryViewProvider = { _, kind, index in
            guard kind == TextHeaderView.elementKind else { return nil }
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: textHeaderRegistration, for: index)
        }

        /// - Tag: Snapshot
        let sections: [DetailSection] = DetailSection.allCases
        var snapshot = NSDiffableDataSourceSnapshot<DetailSection, DetailItem>()
        snapshot.appendSections(sections)
        dataSource.apply(snapshot)

        DetailSection.allCases.forEach { section in
            var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<DetailItem>()
            sectionSnapshot.append(MockDataController.shared.items(with: self.detailItems, for: section))
            dataSource.apply(sectionSnapshot, to: section)
        }
    }
}

/// - Tag: UICollectionViewDelegate
extension DetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if DetailSection(rawValue: indexPath.section) == .main,
           let mainInfo = dataSource.itemIdentifier(for: indexPath)?.main,
            mainInfo.id != nil {
            // TODO: - play trailer
            print("display!")
        }
        if DetailSection(rawValue: indexPath.section) == .plot {
            updatePlotLabelAppearance(indexPath: indexPath, to: .plot)
        }
        collectionView.deselectItem(at: indexPath, animated: false)
    }
    
    func updatePlotLabelAppearance(animated: Bool = true, indexPath: IndexPath, to section: DetailSection) {
        guard let originalPlot = dataSource.itemIdentifier(for: indexPath)?.plot else { return }
        var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<DetailItem>()
        var newPlot = originalPlot
        newPlot.isOpend = !originalPlot.isOpend
        sectionSnapshot.append([.plot(newPlot)])
        dataSource.apply(sectionSnapshot, to: section)
    }
}

/// - Tag: Share
extension DetailViewController {

}
