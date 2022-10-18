//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/18.
//

import UIKit

final class MovieDetailViewController: UIViewController {

    // MARK: Types

    private struct Section: Hashable {
        let title: String?
        let items: [Item]
    }

    private enum Item: Hashable {
        case movie(Movie)
        case review(Review)
    }

    // MARK: UI

    @IBOutlet var collectionView: UICollectionView!

    // MARK: Properties

    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!

    var movie: Movie!

    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        configureDataSource()
    }

    private func configureCollectionView() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            //            let columns = sectionIndex == 0 ? 4 : 1
            let columns = 1
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

            let groupHeight = columns == 1 ?
            NSCollectionLayoutDimension.absolute(44) :
            NSCollectionLayoutDimension.fractionalWidth(0.2)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)

            let headerFooterSize = sectionIndex == 0 ?
            NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(88)) :
            NSCollectionLayoutSize(widthDimension: .absolute(.zero), heightDimension: .absolute(.zero))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: TitleSupplementaryView.reuseIdentifier, alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
            return section
        }
        collectionView.collectionViewLayout = layout
        collectionView.register(TitleSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleSupplementaryView.reuseIdentifier)
    }

    func configureDataSource()  {
        // TODO: MovieCell
        let movieItemRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { cell, indexPath, item in
        }

        // TODO: ReviewCell
        let reviewItemRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { cell, indexPath, item in
            if case .review(let review) = item {
                var content = cell.defaultContentConfiguration()
                content.text = review.nickname
                cell.contentConfiguration = content
            }
        }

        let headerRegistration = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>(elementKind: TitleSupplementaryView.reuseIdentifier) {
            supplementaryView, string, indexPath in
            supplementaryView.nameLabel.text = self.movie.name
            supplementaryView.numberOfMoviegoersLabel.text = "누적관객 \(self.movie.numberOfMoviegoers.string)명"
            supplementaryView.rankingLabel.text = self.movie.ranking.string
            if self.movie.isNewRanking {
                supplementaryView.isNewRankingLabel.text = "NEW"
            } else {
                supplementaryView.isNewRankingInfoView.removeFromSuperview()
            }
            if self.movie.changeRanking == 0 {
                supplementaryView.changeRankingInfoView.removeFromSuperview()
            } else {
                let up = self.movie.changeRanking > 0
                supplementaryView.changeRankingLabel.text = self.movie.changeRanking.string
                supplementaryView.changeRankingImageView.image = up ? UIImage(systemName: "arrowtriangle.up.fill") : UIImage(systemName: "arrowtriangle.down.fill")
                supplementaryView.changeRankingLabel.textColor = up ? .systemPink : .systemBlue
                supplementaryView.changeRankingImageView.tintColor = up ? .systemPink : .systemBlue
            }
        }

        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) {
            (collectionView, indexPath, identifier) -> UICollectionViewCell? in
            return indexPath.section == 0 ?
            collectionView.dequeueConfiguredReusableCell(using: movieItemRegistration, for: indexPath, item: identifier) :
            collectionView.dequeueConfiguredReusableCell(using: reviewItemRegistration, for: indexPath, item: identifier)
        }

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        let movieSection = Section(title: "Movie", items: [])
        let reviews = Review.sampleData.map { Item.review($0) }
        let reviewSection = Section(title: "Review", items: reviews)
        snapshot.appendSections([movieSection, reviewSection])
        snapshot.appendItems(movieSection.items, toSection: movieSection)
        snapshot.appendItems(reviewSection.items, toSection: reviewSection)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

}
