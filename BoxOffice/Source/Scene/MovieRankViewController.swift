//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

class MovieRankViewController: UIViewController {
    
    let movieRankView = MovieRankView()
    private var dataSource: UICollectionViewDiffableDataSource<FirstSection, SimpleMovieInfoEntity>!
    var movieList: [SimpleMovieInfoEntity] = []
    
    override func loadView() {
        view = movieRankView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        configureDataSource()
        getMovieRank()
    }
    
    private func setCollectionView() {
        movieRankView.collectionView.collectionViewLayout = createBasicListLayout()
        movieRankView.collectionView.delegate = self
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<MovieCollectionViewCell, SimpleMovieInfoEntity> { cell, indexPath, movie in
            Task {
                do {
                    let image = try await NetworkManager.shared.getPosterImage(englishName: movie.englishName)
                    cell.posterImageView.image = image
                } catch {
                    print(error.localizedDescription)
                }
                cell.setData(movie)
            }
        }
        
        dataSource = UICollectionViewDiffableDataSource<FirstSection, SimpleMovieInfoEntity>(collectionView: self.movieRankView.collectionView) { collectionView, indexPath, video in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: video)
        }
    }
    
    
    private func getMovieRank() {
        let yesterday = Date(timeIntervalSinceNow: -86400).toString()
        var snapshot = NSDiffableDataSourceSnapshot<FirstSection, SimpleMovieInfoEntity>()
        snapshot.appendSections([.main])
        
        Task {
            do {
                let data = try await NetworkManager.shared.getDailyMovieRank(date: yesterday)
                self.movieList = data
            } catch {
                print(error.localizedDescription)
            }
            await MainActor.run {
                self.movieList.sort(by: {$0.rank < $1.rank})
                snapshot.appendItems(movieList)
                self.dataSource.apply(snapshot, animatingDifferences: true)
            }
        }
    }
    
    private func createBasicListLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(5.0),
                                              heightDimension: .estimated(320))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item, count: movieList.count == 0 ? 10 : movieList.count)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }


}

extension MovieRankViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        let detailInfoViewController = DetailInfoViewController()
        let movie = movieList[indexPath.item]
        detailInfoViewController.simpleMovieInfo = movie
        self.navigationController?.pushViewController(detailInfoViewController, animated: true)
    }
}

enum FirstSection {
    case main
}
