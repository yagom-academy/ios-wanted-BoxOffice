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
        share()
    }
    
    private func configureHierarchy() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        view.addSubview(floatingView)
        view.bringSubviewToFront(floatingView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            floatingView.widthAnchor.constraint(equalToConstant: 180),
            floatingView.heightAnchor.constraint(equalToConstant: 60),
            floatingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            floatingView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130),
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
            let estimatedHeight = CGFloat(300)
            
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
                  let title = section.headerTitle else { return }
            textHeaderView.configure(title: title)
        }

        let trailerCellRegistration = UICollectionView.CellRegistration<TrailerCell, MainInfo>(cellNib: TrailerCell.nib()) { cell, _, mainitem in
            cell.configure(with: mainitem)
        }
        
        let plotCellRegistration = UICollectionView.CellRegistration<PlotCell, PlotInfo>(cellNib: PlotCell.nib()) { cell, _, plot in
            cell.appearanceLabel(isOpend: plot.isOpend)
            cell.configure(with: plot)
        }
       
        let detailCellRegistration = UICollectionView.CellRegistration<DetailInformationCell, DetailInfo>(cellNib: DetailInformationCell.nib()) { cell, _, detailitem in
            cell.configure(with: detailitem)
        }

        /// - Tag: DataSource
        dataSource = UICollectionViewDiffableDataSource<DetailSection, DetailItem>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            switch item {
            case .mainInfo(let mainItem):
                return collectionView.dequeueConfiguredReusableCell(using: trailerCellRegistration, for: indexPath, item: mainItem)
            case .plotInfo(let plot):
                return collectionView.dequeueConfiguredReusableCell(using: plotCellRegistration, for: indexPath, item: plot)
            case .detailInfo(let detailItem):
                return collectionView.dequeueConfiguredReusableCell(using: detailCellRegistration, for: indexPath, item: detailItem)
            }
        })

        dataSource.supplementaryViewProvider = { _, kind, index in
            guard kind == TextHeaderView.elementKind else { return nil }
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: textHeaderRegistration, for: index)
        }

        /// - Tag: Snapshot
        let sections = DetailSection.allCases
        var snapshot = NSDiffableDataSourceSnapshot<DetailSection, DetailItem>()
        snapshot.appendSections(sections)
        dataSource.apply(snapshot)

        DetailSection.allCases.forEach { section in
            var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<DetailItem>()
            sectionSnapshot.append(MovieDataManager.searchItems(detailItems, for: section))
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
        sectionSnapshot.append([.plotInfo(newPlot)])
        dataSource.apply(sectionSnapshot, to: section)
    }
}

/// - Tag: Share
extension DetailViewController {
    private func share() {
        floatingView.shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapShareButton() {
        guard let mainItem = detailItems.filter({ $0.type == "mainInfo" }).first?.main,
              let detailItem = detailItems.filter({ $0.type == "detailInfo" }).first?.detail else { return }
        let poster = UIImage(named: "poster")!
        let title = "\(mainItem.name)\n"
        let totalAttendance = "2,135,334명 관람\n"
        let dailyRanking = "\(String(describing: mainItem.rank))위\n"
        let genres = "\(detailItem.genres.first!)\n"
        let director = "감독: \(detailItem.directors.first!)\n"
        let actors = "배우: 현빈, 손예진, 아무개\n\n"
        let message = "이거 봅시다🥳"
        
        let activityController = UIActivityViewController(activityItems: [poster, title, totalAttendance, dailyRanking, genres, director, actors, message], applicationActivities: nil)
        present(activityController, animated: true)
    }
}
