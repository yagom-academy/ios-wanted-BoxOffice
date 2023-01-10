//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/02.
//

import UIKit

final class MovieDetailViewController: UIViewController {

    private let viewModel: MovieDetailViewModel

    private lazy var movieDetailCollectionView: UICollectionView = {
        let layout = movieDetailCollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = ColorAsset.detailBackgroundColor
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    private lazy var movieDetailDataSource = movieDetailCollectionViewDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorAsset.detailBackgroundColor
        bind()
        setUpMovieDetailCollectionView()
        layout()
        viewModel.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        setUpNavigationBar()
        viewModel.viewWillAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.tintColor = .black
        viewModel.viewWillDisappear()
    }

    init(movieOverview: MovieOverview) {
        self.viewModel = MovieDetailViewModel(movieOverview: movieOverview)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.viewModel = MovieDetailViewModel(movieOverview: dummyMovieOverview)
        super.init(coder: coder)
    }

    private func setUpNavigationBar() {
        let button = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"),
                                     style: .plain, target: self, action: #selector(shareButtonTapped(_:)))
        navigationItem.setRightBarButton(button, animated: false)

        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = ColorAsset.detailBackgroundColor
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }

    private func bind() {
        viewModel.applyDataSource = { [weak self] in
            DispatchQueue.main.async {
                self?.applyDataSource()
            }
        }
        viewModel.scrollToUpper = { [weak self] in
            let upperMovieInfoIndexPath = IndexPath(row: 0, section: 0)
            if self?.movieDetailCollectionView.cellForItem(at: upperMovieInfoIndexPath) != nil {
                self?.movieDetailCollectionView.scrollToItem(at: upperMovieInfoIndexPath, at: .top, animated: false)
            }
        }
        viewModel.presentViewController = { [weak self] viewController in
            self?.present(viewController, animated: true)
        }
        viewModel.startLoadingIndicator = { [weak self] in
            DispatchQueue.main.async {
                self?.loadingIndicator.startAnimating()
            }
        }
        viewModel.stopLoadingIndicator = { [weak self] in
            DispatchQueue.main.async {
                self?.loadingIndicator.stopAnimating()
            }
        }
    }

    private func setUpMovieDetailCollectionView() {
        movieDetailCollectionView.register(MovieDetailUpperCollectionViewCell.self,
                                           forCellWithReuseIdentifier: MovieDetailUpperCollectionViewCell.reuseIdentifier)
        movieDetailCollectionView.register(MovieDetailInfoCollectionViewCell.self,
                                           forCellWithReuseIdentifier: MovieDetailInfoCollectionViewCell.reuseIdentifier)
        movieDetailCollectionView.register(MovieDetailReviewCollectionViewCell.self,
                                           forCellWithReuseIdentifier: MovieDetailReviewCollectionViewCell.reuseIdentifier)
        movieDetailCollectionView.register(AverageReviewCollectionViewCell.self,
                                           forCellWithReuseIdentifier: AverageReviewCollectionViewCell.reuseIdentifier)
        movieDetailCollectionView.register(MovieDetailTabBarHeaderView.self,
                                           forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                           withReuseIdentifier: MovieDetailTabBarHeaderView.reuseIdentifier)
        movieDetailCollectionView.dataSource = movieDetailDataSource
        movieDetailCollectionView.delegate = self
        movieDetailCollectionView.contentInsetAdjustmentBehavior = .never
    }

    private func layout() {
        [movieDetailCollectionView, loadingIndicator].forEach {
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            movieDetailCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieDetailCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            movieDetailCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            movieDetailCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: - DataSource
    private func movieDetailCollectionViewDataSource() -> UICollectionViewDiffableDataSource<MovieDetailSection, MovieDetailItem> {
        let dataSource = UICollectionViewDiffableDataSource<MovieDetailSection, MovieDetailItem>(
            collectionView: movieDetailCollectionView
        ) { [weak self] collectionView, indexPath, itemIdentifier -> UICollectionViewCell? in
            guard let self = self else { return UICollectionViewCell() }
            if indexPath.section == MovieDetailSection.upper.rawValue {
                if case let .upper(movieDetail) = itemIdentifier,
                   let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MovieDetailUpperCollectionViewCell.reuseIdentifier,
                    for: indexPath
                   ) as? MovieDetailUpperCollectionViewCell {
                    cell.setUpContents(movieDetail: movieDetail.0, movieOverview: self.viewModel.movieOverview, posterImage: self.viewModel.posterImage)
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
                    cell.setUpContents(movieDetail: movieDetail, movieOverview: self.viewModel.movieOverview)
                    return cell
                }
            case .review:
                guard case let .review(review) = itemIdentifier else { return UICollectionViewCell() }

                if indexPath.row != 0,
                    let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MovieDetailReviewCollectionViewCell.reuseIdentifier,
                    for: indexPath
                   ) as? MovieDetailReviewCollectionViewCell {
                    cell.setUpContents(review: review)
                    cell.deleteButtonTapped = { [weak self] in
                        self?.viewModel.deleteReviewButtonTapped(review: review)
                    }
                    return cell
                }

                if indexPath.row == 0,
                    let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: AverageReviewCollectionViewCell.reuseIdentifier,
                    for: indexPath
                   ) as? AverageReviewCollectionViewCell {
                    cell.setUpContents(averageRating: self.viewModel.averageRating,
                                       movieTitle: self.viewModel.movieDetail.title)
                    cell.reviewWriteButtonTapped = { [weak self] in
                        guard let self = self else { return }
                        self.navigationController?
                            .pushViewController(MovieReviewViewController(movieCode: self.viewModel.movieDetail.movieCode),
                                                animated: true)
                    }
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
            header.tabBarButtonTapped = { [weak self] mode in
                self?.viewModel.tabBarModeChanged(mode: mode)
            }

            indexPath.section == MovieDetailSection.upper.rawValue ? header.removeSubviews() : header.setUpContents()
            return header
        }

        return dataSource
    }

    private func applyDataSource() {
        var snapShot = NSDiffableDataSourceSnapshot<MovieDetailSection, MovieDetailItem>()
        snapShot.appendSections([.upper, .bottom])
        snapShot.appendItems([.upper(viewModel.movieDetail, viewModel.posterImage)], toSection: .upper)
        if viewModel.tabBarMode == .movieInfo {
            snapShot.appendItems([.info(viewModel.movieDetail)], toSection: .bottom)
        } else {
            snapShot.appendItems([.review(dummyMovieReview)], toSection: .bottom)
            viewModel.movieReviews.forEach {
                snapShot.appendItems([.review($0)], toSection: .bottom)
            }
        }
        movieDetailDataSource.apply(snapShot)
    }

    // MARK: - CollectionViewLayout
    private func movieDetailCollectionViewLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 0
        configuration.scrollDirection = .vertical

        let compositionalLayout = UICollectionViewCompositionalLayout(sectionProvider: { section, environment in
            switch section {
            case MovieDetailSection.upper.rawValue:
                return MovieDetailSection.upper.section
            case MovieDetailSection.bottom.rawValue:
                return MovieDetailSection.bottom.section
            default:
                return MovieDetailSection.upper.section
            }
        }, configuration: configuration)

        return compositionalLayout
    }

    @objc
    private func shareButtonTapped(_ sender: UIBarButtonItem) {
        viewModel.shareButtonTapped(screenImage: movieDetailCollectionView.convertToImage())
    }
}

// MARK: - MoviewDetailDiffableDataSource Item Wrapper
extension MovieDetailViewController {
    /// Wrapper Enum to use DiffableDataSource
    enum MovieDetailItem: Hashable {
        case upper(MovieDetail, UIImage?)
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
                let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
                let item = NSCollectionLayoutItem(layoutSize: size)
                item.edgeSpacing = .init(leading: .fixed(0), top: .fixed(10), trailing: .fixed(0), bottom: .fixed(10))
                return item
            }
        }

        var group: NSCollectionLayoutGroup {
            switch self {
            case .upper:
                let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(600))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
                return group
            case .bottom:
                let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
                return group
            }
        }

        var section: NSCollectionLayoutSection {
            let section = NSCollectionLayoutSection(group: group)
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(0.1)
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

// MARK: - UICollectionViewDelegate
extension MovieDetailViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isShowingUpperInfoview = scrollView.contentOffset.y <= 0
        movieDetailCollectionView.contentInsetAdjustmentBehavior = isShowingUpperInfoview ? .never : .automatic
    }
}

// MARK: - UIView extension
fileprivate extension UIView {
  func convertToImage() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
