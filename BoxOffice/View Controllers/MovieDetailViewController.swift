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

    static let reuseIdentifier = "reuse-identifier"

    // MARK: Types

    private enum Section: Int, CaseIterable {
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

    // MARK: UI

    @IBOutlet private var collectionView: UICollectionView!

    // MARK: Properties

    private let movieSearchService = MovieSearchService()

    var movie: MovieRanking!

    @Published private var movieDetail: MovieDetail!
    private var cancellables: Set<AnyCancellable> = .init()
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!

    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        configureDataSource()
        configureMovieRankingView()
        configureObserver()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

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
                elementKind: Self.reuseIdentifier,
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
                let section = NSCollectionLayoutSection.list(
                    using: .init(appearance: .plain),
                    layoutEnvironment: layoutEnvironment
                )
                section.contentInsets = sectionContentInset
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            }
        }
        collectionView.collectionViewLayout = layout
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Self.reuseIdentifier)
    }

    private func configureDataSource()  {
        // Cell Registration
        let infoItemRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, AnyHashable> { cell, indexPath, item in
            if let info = item as? MovieDetailInfo {
                var content = UIListContentConfiguration.valueCell()
                content.text = info.title
                content.textProperties.font = .preferredFont(forTextStyle: .footnote)
                content.secondaryText = info.value
                content.secondaryTextProperties.font = .preferredFont(forTextStyle: .footnote)
                content.directionalLayoutMargins = .zero
                cell.contentConfiguration = content
            }
        }

        let crewItemRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, AnyHashable> { cell, indexPath, item in
            if let crew = item as? Crew {
                var content = UIListContentConfiguration.cell()
                content.text = crew.name
                content.textProperties.alignment = .center
                content.textProperties.font = .preferredFont(forTextStyle: .caption1)
                content.secondaryText = crew.displayRole
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

        let reviewItemRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, AnyHashable> { cell, indexPath, item in
            if let review = item as? MovieReview {
                var content = UIListContentConfiguration.subtitleCell()
                content.text = review.nickname
                content.textProperties.font = .preferredFont(forTextStyle: .footnote)
                content.secondaryText = review.content
                content.secondaryTextProperties.font = .preferredFont(forTextStyle: .footnote)
                content.secondaryTextProperties.numberOfLines = 0
                content.image = UIImage(systemName: "person.fill")
                cell.contentConfiguration = content
            }
        }

        // HeaderRegistraion
        let headerRegistration = UICollectionView.SupplementaryRegistration<UICollectionViewCell>(elementKind: Self.reuseIdentifier) { supplementaryView, elementKind, indexPath in
            var config = UIListContentConfiguration.plainHeader()
            config.text = self.dataSource.snapshot().sectionIdentifiers[indexPath.section].title
            supplementaryView.contentConfiguration = config
        }

        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: collectionView) {
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

        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems([], toSection: .crew)
        snapshot.appendItems([], toSection: .info)
        snapshot.appendItems(MovieReview.sampleData, toSection: .review)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    private func configureMovieRankingView() {
        let movieRankingView = MovieRankingView(frame: .zero)
        movieRankingView.translatesAutoresizingMaskIntoConstraints = false

        let height: CGFloat = 88
        collectionView.addSubview(movieRankingView)
        NSLayoutConstraint.activate([
            movieRankingView.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: -height),
            movieRankingView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            movieRankingView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            movieRankingView.heightAnchor.constraint(equalToConstant: height),
        ])
        collectionView.contentInset = UIEdgeInsets(top: height, left: 0, bottom: 0, right: 0)
        movieRankingView.configure(with: movie)
    }

    private func configureObserver() {
        $movieDetail
            .receive(on: DispatchQueue.main)
            .sink { [weak self] detail in
                guard let detail = detail else { return }
                self?.updateView(with: detail)
            }
            .store(in: &cancellables)
    }

    private func updateView(with detail: MovieDetail) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(detail.crew, toSection: .crew)
        snapshot.appendItems(detail.info, toSection: .info)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    private func fetchMovieDetail() {
        Task {
            do {
                let detail = try await movieSearchService.searchMovieDetail(for: movie.identifier)
                self.movieDetail = detail
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

}

// MARK: - UICollectionViewDelegate

extension MovieDetailViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return indexPath.section == Section.review.rawValue
    }

}

// MARK: - MovieDetail

fileprivate extension MovieDetail {

    /// 감독 및 출연진
    var crew: [Crew] {
        directors + actors
    }

    /// 영화 상세정보
    var info: [MovieDetailInfo] {
        [
            .init(title: "개봉", value: openDate.dateString()),
            .init(title: "제작", value: productionDate),
            .init(title: "장르", value: genres.joined()),
            .init(title: "관람등급", value: watchGrade),
        ]
    }

}

// MARK: - MovieDetailInfo

fileprivate struct MovieDetailInfo: Hashable {

    let title: String
    let value: String

}
