//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

final class MovieListViewController: UIViewController {
    private let viewModel = MovieListViewModel()

    private lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl()
        let daySegmentSelected: ((UIAction) -> Void) = { [weak self] _ in
            self?.viewModel.dayTypeSegmentValueChanged(value: .day)
        }
        let weekendSegmentSelected: ((UIAction) -> Void) = { [weak self] _ in
            self?.viewModel.dayTypeSegmentValueChanged(value: .weekDaysAndWeekend)
        }
        segmentControl.setAction(UIAction(handler: daySegmentSelected), forSegmentAt: 0)
        segmentControl.setAction(UIAction(handler: weekendSegmentSelected), forSegmentAt: 1)
        return segmentControl
    }()
    
    private lazy var movieListCollectionView: UICollectionView = {
        let layout = movieListCollectionViewLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: movieListCollectionViewLayout()
        )
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.viewDidLoad()
        registerCollectionViewCells()
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
            self.movieListCollectionView.reloadData()
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
    private func registerCollectionViewCells() {
        self.movieListCollectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: MovieListCollectionViewCell.reuseIdentifier)
    }
    
    func addViews() {
        view.addSubview(movieListCollectionView)
    }
    
    func setupUILayouts() {
        NSLayoutConstraint.activate([
            movieListCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieListCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            movieListCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieListCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}
