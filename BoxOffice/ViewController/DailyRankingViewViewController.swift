//
//  DailyRankingViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

final class DailyRankingViewController: UIViewController {
    private var dataSource: UICollectionViewDiffableDataSource<RankingSection, RankingItem>!
    
    private let boxOfficeLabelBackgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "backgroundBlue")
        return imageView
    }()
    
    private let boxOfficeLabel: UILabel = {
        // TODO: - Navigation Title로 변경해야 함 (뷰높이 == detailView collectionView top)
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "BoxOffice"
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureDataSource()
    }
    
    private func configureHierarchy() {
        [boxOfficeLabelBackgroundView, boxOfficeLabel, collectionView].forEach { view.addSubview($0) }
        
        let spacing = CGFloat(15)
        NSLayoutConstraint.activate([
            boxOfficeLabelBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boxOfficeLabelBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            boxOfficeLabelBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            boxOfficeLabelBackgroundView.heightAnchor.constraint(equalToConstant: 130),
            
            boxOfficeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing),
            boxOfficeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacing),
            boxOfficeLabel.bottomAnchor.constraint(equalTo: boxOfficeLabelBackgroundView.bottomAnchor, constant: -spacing),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: boxOfficeLabelBackgroundView.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

/// - Tag: Layout
extension DailyRankingViewController {
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            let section = RankingSection(rawValue: sectionIndex)!
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
            let defaultSpacing = CGFloat(15)
            let bottomSpacing = CGFloat(45)
            
            switch section {
            // Onboarding cell layout
            case .onboarding:
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.4))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: bottomSpacing, trailing: 0)
                return section
                
            // Ranking cell layout
            case .ranking:
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalWidth(0.7))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = defaultSpacing
                section.contentInsets = NSDirectionalEdgeInsets(top: defaultSpacing, leading: defaultSpacing, bottom: bottomSpacing, trailing: defaultSpacing)
                
                let rankingHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: RankingHeaderView.elementKind, alignment: .top)
                section.boundarySupplementaryItems = [rankingHeader]
                return section
            }
        }
        return layout
    }
}

extension DailyRankingViewController {
    private func configureDataSource() {
        /// - Tag: Registration
        let rankingHeaderRegistration = UICollectionView.SupplementaryRegistration<RankingHeaderView>(supplementaryNib: RankingHeaderView.nib(), elementKind: RankingHeaderView.elementKind) { rankingHeaderView, _, indexPath in
        guard RankingSection(rawValue: indexPath.section) == .ranking else { return }
        // TODO: -
        }
        
        let onboardingCellRegistration = UICollectionView.CellRegistration<OnboardingCell, Banner>(cellNib: OnboardingCell.nib()) { cell, _, item in
            cell.configure(with: item)
        }
        
        let rankingCellRegistration = UICollectionView.CellRegistration<RankingCell, Movie>(cellNib: RankingCell.nib()) { cell, _, item in
            cell.configure(with: item)
        }
        
        /// - Tag: DataSource
        dataSource = UICollectionViewDiffableDataSource<RankingSection, RankingItem>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            switch item {
            case .banner(let onboardingItem):
                return collectionView.dequeueConfiguredReusableCell(using: onboardingCellRegistration, for: indexPath, item: onboardingItem)
            case .ranking(let rankingItem):
                return collectionView.dequeueConfiguredReusableCell(using: rankingCellRegistration, for: indexPath, item: rankingItem)
            }
        })

        dataSource.supplementaryViewProvider = { [weak self] _, kind, index in
            guard let self = self,
                  kind == RankingHeaderView.elementKind else { return nil }
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: rankingHeaderRegistration, for: index)
        }
        
        /// - Tag: Snapshot
        let sections: [RankingSection] = RankingSection.allCases
        var snapshot = NSDiffableDataSourceSnapshot<RankingSection, RankingItem>()
        snapshot.appendSections(sections)
        dataSource.apply(snapshot)
        
        RankingSection.allCases.forEach { section in
            let sectionItems = MockDataController.shared.items(for: section)
            var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<RankingItem>()
            sectionSnapshot.append(sectionItems)
            dataSource.apply(sectionSnapshot, to: section)
        }
    }
}

/// - Tag: UICollectionViewDelegate
extension DailyRankingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath),
              RankingSection(rawValue: indexPath.section) == .ranking,
              let movie: Movie = item.ranking else {
            collectionView.deselectItem(at: indexPath, animated: true)
            return
        }
        let detailViewController = DetailViewController()
        let mainItem = DetailItem.main(movie.main)
        let plotItem = DetailItem.plot(movie.plot)
        let detailItem = DetailItem.detail(movie.detail)
        detailViewController.detailItems = [mainItem, plotItem, detailItem]
        configureBackBarButton(with: movie.main.koreanName)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    private func configureBackBarButton(with title: String) {
        let backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: nil)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold)]
        backBarButtonItem.tintColor = #colorLiteral(red: 0.2267841101, green: 0.3251087368, blue: 0.6446369886, alpha: 1)
        backBarButtonItem.setTitleTextAttributes(attributes, for: .normal)
        navigationItem.backBarButtonItem = backBarButtonItem
    }
}
