//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

final class MovieListViewController: UIViewController {
    private let viewModel = MovieListViewModel()

    private var diffableDataSource: UICollectionViewDiffableDataSource<Section, MovieOverview>!
    
    private lazy var dayTypeSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["주간", "주말"])
        
        let daySegmentSelected: ((UIAction) -> Void) = { [weak self] _ in
            self?.viewModel.dayTypeSegmentValueChanged(value: .day)
        }
        let weekendSegmentSelected: ((UIAction) -> Void) = { [weak self] _ in
            self?.viewModel.dayTypeSegmentValueChanged(value: .weekDaysAndWeekend)
        }
        segmentedControl.setAction(UIAction(title: "주간", handler: daySegmentSelected), forSegmentAt: 0)
        segmentedControl.setAction(UIAction(title: "주말", handler: weekendSegmentSelected), forSegmentAt: 1)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    private lazy var movieListCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: movieListCollectionViewLayout()
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.viewDidLoad()
        bind()
        
        registerCollectionViewCells()
        setupCellProvider()
        applySnapshot(movieOverviews: self.viewModel.movieOverviewList)
        
        addViews()
        setupUILayouts()
    }
    
    private func movieListCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(200.0)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 1
        )
        
        let section = NSCollectionLayoutSection(group: group)
        let compositionalLayout = UICollectionViewCompositionalLayout(section: section)
        
        return compositionalLayout
    }

    private func bind() {
        viewModel.applySnapShot = {
            self.applySnapshot(movieOverviews: self.viewModel.movieOverviewList)
        }
    }
}

extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.movieOverviewList.count - 1 {
            viewModel.scrollEnded()
        }
    }
}

extension MovieListViewController {
    enum Section {
        case main
    }
}
extension MovieListViewController {
    private func setupCellProvider() {
        self.diffableDataSource = UICollectionViewDiffableDataSource<Section, MovieOverview>(collectionView: self.movieListCollectionView)
        { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.reuseIdentifier, for: indexPath) as? MovieListCollectionViewCell else {
                return MovieListCollectionViewCell()
            }
            
            cell.layer.borderWidth = 0.2
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.setupContents(movieOverview: itemIdentifier)
            
            return cell
        }
    }
    
    private func registerCollectionViewCells() {
        self.movieListCollectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: MovieListCollectionViewCell.reuseIdentifier)
    }
    
    
    private func applySnapshot(movieOverviews: [MovieOverview]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MovieOverview>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movieOverviews)
        self.diffableDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func addViews() {
        view.addSubview(movieListCollectionView)
        view.addSubview(dayTypeSegmentedControl)
    }
    
    func setupUILayouts() {
        NSLayoutConstraint.activate([
            dayTypeSegmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            dayTypeSegmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            dayTypeSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dayTypeSegmentedControl.heightAnchor.constraint(equalToConstant: 30),
            
            movieListCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieListCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            movieListCollectionView.topAnchor.constraint(equalTo: dayTypeSegmentedControl.safeAreaLayoutGuide.bottomAnchor, constant: 16),
            movieListCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
