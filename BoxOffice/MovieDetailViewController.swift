//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/02.
//

import UIKit

final class MovieDetailViewController: UIViewController {

    private let viewModel = MovieDetailViewModel()

    private lazy var movieDetailCollectionView: UICollectionView = {
        let layout = movieDetailCollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var movieDetailDataSource = movieDetailCollectionViewDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpMovieDetailCollectionView()
        layout()
        applyDataSource()
    }

    private func setUpMovieDetailCollectionView() {
        movieDetailCollectionView.register(MovieDetailUpperCollectionViewCell.self,
                                           forCellWithReuseIdentifier: MovieDetailUpperCollectionViewCell.reuseIdentifier)
        movieDetailCollectionView.register(MovieDetailInfoCollectionViewCell.self,
                                           forCellWithReuseIdentifier: MovieDetailInfoCollectionViewCell.reuseIdentifier)
        movieDetailCollectionView.register(MovieDetailReviewCollectionViewCell.self,
                                           forCellWithReuseIdentifier: MovieDetailReviewCollectionViewCell.reuseIdentifier)
        movieDetailCollectionView.register(MovieDetailTabBarHeaderView.self,
                                           forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                           withReuseIdentifier: MovieDetailTabBarHeaderView.reuseIdentifier)
        movieDetailCollectionView.dataSource = movieDetailDataSource
    }

    private func layout() {
        view.addSubview(movieDetailCollectionView)

        NSLayoutConstraint.activate([
            movieDetailCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieDetailCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            movieDetailCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieDetailCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func movieDetailCollectionViewDataSource() -> UICollectionViewDiffableDataSource<MovieDetailSection, MovieDetailItem> {
        let dataSource = UICollectionViewDiffableDataSource<MovieDetailSection, MovieDetailItem>(
            collectionView: movieDetailCollectionView
        ) { collectionView, indexPath, itemIdentifier -> UICollectionViewCell? in

            if indexPath.section == MovieDetailSection.upper.rawValue {
                if case let .upper(movieDetail) = itemIdentifier,
                   let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MovieDetailUpperCollectionViewCell.reuseIdentifier,
                    for: indexPath
                   ) as? MovieDetailUpperCollectionViewCell {
                    cell.setUpContents(movieDetail: movieDetail)
                    return cell
                }
            }

            switch self.viewModel.tabBarMode {
            case .movieInfo:
                if case let .info(movieDetail) = itemIdentifier,
                   let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MovieDetailInfoCollectionViewCell.reuseIdentifier,
                    for: indexPath
                   ) as? MovieDetailInfoCollectionViewCell {
                    cell.setUpContents(movieDetail: movieDetail)
                    return cell
                }
            case .review:
                if case let .review(review) = itemIdentifier,
                   let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MovieDetailReviewCollectionViewCell.reuseIdentifier,
                    for: indexPath
                   ) as? MovieDetailReviewCollectionViewCell {
                    cell.setUpContents(review: review)
                    return cell
                }
            }
            return UICollectionViewCell()
        }
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader,
                  let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: MovieDetailTabBarHeaderView.reuseIdentifier,
                    for: indexPath
                  ) as? MovieDetailTabBarHeaderView else { return UICollectionReusableView() }
            if indexPath.section != MovieDetailSection.upper.rawValue {
                header.setUpContents()
            }
            return header
        }

        return dataSource
    }

    private func applyDataSource() {
        var snapShot = NSDiffableDataSourceSnapshot<MovieDetailSection, MovieDetailItem>()
        snapShot.appendSections([.upper, .bottom])
        snapShot.appendItems([], toSection: .upper)
        snapShot.appendItems([], toSection: .bottom)
        movieDetailDataSource.apply(snapShot)
    }

    private func movieDetailCollectionViewLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 20
        configuration.scrollDirection = .vertical

        let compositionalLayout = UICollectionViewCompositionalLayout(sectionProvider: { section, environment in
            switch section {
            case MovieDetailSection.upper.rawValue:
                return MovieDetailSection.upper.section
            case MovieDetailSection.bottom.rawValue:
                return MovieDetailSection.upper.section
            default:
                return MovieDetailSection.upper.section
            }
        }, configuration: configuration)

        return compositionalLayout
    }
}

// MARK: - MoviewDetailDiffableDataSource
extension MovieDetailViewController {
    /// Wrapper Enum to use DiffableDataSource
    enum MovieDetailItem: Hashable {
        case upper(MovieDetail)
        case info(MovieDetail)
        case review(MovieReview)
    }
}

// MARK: - MovieDetailSection
extension MovieDetailViewController {
    enum MovieDetailSection: Int, CaseIterable {
        case upper
        case bottom

        var item: NSCollectionLayoutItem {
            switch self {
            case .upper:
                let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
                return NSCollectionLayoutItem(layoutSize: size)
            case .bottom:
                let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
                return NSCollectionLayoutItem(layoutSize: size)
            }
        }

        var group: NSCollectionLayoutGroup {
            switch self {
            case .upper:
                let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(600))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
                return group
            case .bottom:
                let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
                return group
            }
        }

        var section: NSCollectionLayoutSection {
            let section = NSCollectionLayoutSection(group: group)
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(100)
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            header.pinToVisibleBounds = true
            section.boundarySupplementaryItems = [header]
            return section
        }
    }
}
