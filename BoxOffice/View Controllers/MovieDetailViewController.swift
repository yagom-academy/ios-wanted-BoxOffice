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

    var movie: Movie?

    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        configureDataSource()
    }

    private func configureCollectionView() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let columns = sectionIndex == 0 ? 4 : 1

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
            return section
        }
        collectionView.collectionViewLayout = layout
    }

    func configureDataSource()  {
        // TODO: MovieCell
        let movieItemRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { cell, indexPath, item in
            if case .movie(let movie) = item {
                var content = cell.defaultContentConfiguration()
                content.text = movie.name
                cell.contentConfiguration = content
            }
        }

        // TODO: ReviewCell
        let reviewItemRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { cell, indexPath, item in
            if case .review(let review) = item {
                var content = cell.defaultContentConfiguration()
                content.text = review.nickname
                cell.contentConfiguration = content
            }
        }

        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) {
            (collectionView, indexPath, identifier) -> UICollectionViewCell? in
            return indexPath.section == 0 ?
            collectionView.dequeueConfiguredReusableCell(using: movieItemRegistration, for: indexPath, item: identifier) :
            collectionView.dequeueConfiguredReusableCell(using: reviewItemRegistration, for: indexPath, item: identifier)
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        let movieSection = Section(title: "Movie", items: [Item.movie(movie!)])
        let reviews = Review.sampleData.map { Item.review($0) }
        let reviewSection = Section(title: "Review", items: reviews)
        snapshot.appendSections([movieSection, reviewSection])
        snapshot.appendItems(movieSection.items, toSection: movieSection)
        snapshot.appendItems(reviewSection.items, toSection: reviewSection)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

}
