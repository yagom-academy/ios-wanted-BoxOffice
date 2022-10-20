//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/18.
//

import UIKit
import Combine

final class MovieDetailViewController: UIViewController {

    // MARK: Constants

    static let headerResuseIdentifier = "headerResuseIdentifier"

    // MARK: UI

    @IBOutlet private var collectionView: UICollectionView!

    // MARK: Properties

    private let movieSearchService = MovieSearchService()
    private let movieReviewService = MovieReviewService()

    var movieRanking: MovieRanking!

    @Published private var movieDetail: MovieDetail!
    @Published private var movieReviews: [MovieReview] = []
    private var cancellables: Set<AnyCancellable> = .init()
    private var dataSource: DataSource!

    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        subscribe()
        configureCollectionView()
        configureDataSource()
        updateView(with: movieRanking)
        fetchMovieReviews()
        fetchMovieDetail()
    }

    // MARK: Configure

    private func configureCollectionView() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionIndex = Section(rawValue: sectionIndex) else { return nil }

            let sectionContentInset = NSDirectionalEdgeInsets(
                top: 0,
                leading: 0,
                bottom: 12,
                trailing: 00
            )
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44)),
                elementKind: Self.headerResuseIdentifier,
                alignment: .topLeading
            )

            switch sectionIndex {
            case .info:
                let section = NSCollectionLayoutSection.list(
                    using: .init(appearance: .plain),
                    layoutEnvironment: layoutEnvironment
                )
                section.contentInsets = sectionContentInset
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            case .crew:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.28),
                    heightDimension: .fractionalWidth(0.28)
                )
                let group = NSCollectionLayoutGroup
                    .horizontal(
                        layoutSize: groupSize,
                        subitems: [item]
                    )
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.orthogonalScrollingBehavior = .groupPaging
                let sectionContentInset = NSDirectionalEdgeInsets(
                    top: 0,
                    leading: 12,
                    bottom: 12,
                    trailing: 0
                )
                section.contentInsets = sectionContentInset
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            case .review:
                var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
                configuration.trailingSwipeActionsConfigurationProvider = { [weak self] indexPath in
                    guard let item = self?.dataSource.itemIdentifier(for: indexPath) else { fatalError() }
                    return self?.trailingSwipeActionConfigurationForListCellItem(item)
                }
                let section = NSCollectionLayoutSection.list(
                    using: configuration,
                    layoutEnvironment: layoutEnvironment
                )
                section.contentInsets = sectionContentInset
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            }
        }
        collectionView.collectionViewLayout = layout
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Self.headerResuseIdentifier)
    }

    fileprivate func trailingSwipeActionConfigurationForListCellItem(_ item: AnyHashable) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            [weak self] (_, _, completion) in
            guard let self = self,
                  let review = item as? MovieReview else {
                completion(false)
                return
            }
//            self.movieReviewService.deleteReview(review)
            print(item)
            print(review)
            completion(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    private func configureDataSource()  {
        // Cell Registration
        let infoItemRegistration = CellRegistration { cell, indexPath, item in
            if let info = item as? Item {
                var content = UIListContentConfiguration.valueCell()
                content.text = info.title
                content.textProperties.font = .preferredFont(forTextStyle: .footnote)
                content.secondaryText = info.value
                content.secondaryTextProperties.font = .preferredFont(forTextStyle: .footnote)
                content.directionalLayoutMargins = .zero
                cell.contentConfiguration = content
            }
        }

        let crewItemRegistration = CellRegistration { cell, indexPath, item in
            if let crew = item as? Crew {
                var content = UIListContentConfiguration.cell()
                content.text = crew.name
                content.textProperties.alignment = .center
                content.textProperties.font = .preferredFont(forTextStyle: .caption1)
                content.secondaryText = crew.role
                content.secondaryTextProperties.alignment = .center
                content.secondaryTextProperties.font = .preferredFont(forTextStyle: .caption2)
                content.secondaryTextProperties.color = .secondaryLabel
                content.directionalLayoutMargins = .zero
                cell.contentConfiguration = content

                var background = UIBackgroundConfiguration.listPlainCell()
                background.backgroundColor = .systemGroupedBackground
                background.cornerRadius = 8
                background.strokeColor = .systemGray3
                background.strokeWidth = 1.0 / cell.traitCollection.displayScale
                cell.backgroundConfiguration = background
            }
        }

        let reviewItemRegistration = CellRegistration { cell, indexPath, item in
            if let review = item as? MovieReview {
                var content = UIListContentConfiguration.subtitleCell()
                let ratingText = "\(String(repeating: "★", count: review.rating))\(String(repeating: "☆", count: 5 - review.rating))"
                content.text = "\(review.nickname) \(ratingText)"
                content.textProperties.font = .preferredFont(forTextStyle: .caption2)
                content.textProperties.color = .secondaryLabel
                content.secondaryText = review.content
                content.secondaryTextProperties.font = .preferredFont(forTextStyle: .caption1)
                content.secondaryTextProperties.numberOfLines = 0
                content.image = UIImage(systemName: "person.circle.fill")
                content.imageProperties.tintColor = .secondarySystemFill
                cell.contentConfiguration = content
            }
        }

        // HeaderRegistraion
        let headerRegistration = SupplementaryRegistration(elementKind: Self.headerResuseIdentifier) { supplementaryView, elementKind, indexPath in
            var config = UIListContentConfiguration.plainHeader()
            config.text = self.dataSource.snapshot().sectionIdentifiers[indexPath.section].title
            supplementaryView.contentConfiguration = config
        }

        dataSource = DataSource(collectionView: collectionView) {
            (collectionView, indexPath, identifier) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else { return nil }
            switch section {
            case .crew:
                return collectionView.dequeueConfiguredReusableCell(
                    using: crewItemRegistration,
                    for: indexPath,
                    item: identifier
                )
            case .info:
                return collectionView.dequeueConfiguredReusableCell(
                    using: infoItemRegistration,
                    for: indexPath,
                    item: identifier
                )
            case .review:
                return collectionView.dequeueConfiguredReusableCell(
                    using: reviewItemRegistration,
                    for: indexPath,
                    item: identifier
                )
            }
        }

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration,
                for: indexPath
            )
        }

        var snapshot = Snapshot()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems([], toSection: .crew)
        snapshot.appendItems([], toSection: .info)
        snapshot.appendItems([], toSection: .review)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    private func subscribe() {
        $movieDetail
            .receive(on: DispatchQueue.main)
            .sink { [weak self] detail in
                guard let detail = detail else { return }
                self?.updateView(with: detail)
            }
            .store(in: &cancellables)

        $movieReviews
            .receive(on: DispatchQueue.main)
            .sink { [weak self] reviews in
                self?.updateView(with: reviews)
            }
            .store(in: &cancellables)
    }

    private func updateView(with ranking: MovieRanking) {
        navigationItem.title = ranking.name
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(ranking.info, toSection: .info)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    private func updateView(with detail: MovieDetail) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(detail.crew, toSection: .crew)
        snapshot.appendItems(detail.info, toSection: .info)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    private func updateView(with reviews: [MovieReview]) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(reviews, toSection: .review)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    private func fetchMovieDetail() {
        Task {
            do {
                let detail = try await movieSearchService.searchMovieDetail(for: movieRanking.identifier)
                self.movieDetail = detail
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

    private func fetchMovieReviews() {
        Task {
            do {
                let reviews = try await movieReviewService.reviews(for: movieRanking.identifier)
                self.movieReviews = reviews
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

    // MARK: Navigation

    @IBAction
    func unwindToMovieDetail(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddMovieReviewViewController,
           let review = sourceViewController.review {
            movieReviewService.addReview(review)
            self.fetchMovieReviews()
        }
    }

}

// MARK: - UICollectionViewDelegate

extension MovieDetailViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return indexPath.section == Section.review.rawValue
    }

}

// MARK: - Types

fileprivate typealias DataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>
fileprivate typealias Snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>
fileprivate typealias CellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, AnyHashable>
fileprivate typealias SupplementaryRegistration = UICollectionView.SupplementaryRegistration<UICollectionViewCell>

// MARK: Section

fileprivate enum Section: Int, CaseIterable {
    case info
    case crew
    case review

    var title: String? {
        switch self {
        case .crew: return "감독 및 출연진"
        case .info: return "정보"
        case .review: return "평가 및 리뷰"
        }
    }
}

// MARK: MovieDetail

fileprivate extension MovieDetail {

    var crew: [Crew] {
        directors + actors
    }

    var info: [Item] {
        [
            .init(title: "개봉", value: "\(openDate.year) 년"),
            .init(title: "제작", value: "\(productionDate) 년"),
            .init(title: "장르", value: genres.joined()),
            .init(title: "관람등급", value: watchGrade),
        ]
    }

}

fileprivate extension MovieRanking {

    var changeRankingDisplayText: String {
        if changeRanking > 0 {
            return "+\(changeRanking.string)"
        } else if changeRanking == 0 {
            return "-"
        } else {
            return changeRanking.string
        }
    }

    var info: [Item] {
        [
            .init(title: "순위", value: "\(ranking.string) (\(changeRankingDisplayText))"),
            .init(title: "신규진입", value: isNewRanking ? "Y" : "N"),
            .init(title: "누적관객", value: "\(numberOfMoviegoers.string) 명")
        ]
    }

}

// MARK: MovieDetailInfo

fileprivate struct Item: Hashable {

    let title: String
    let value: String

}
