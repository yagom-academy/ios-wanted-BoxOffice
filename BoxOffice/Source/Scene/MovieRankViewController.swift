//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

class MovieRankViewController: UIViewController {
    
    let movieRankView = MovieRankView()
    private var dataSource: UICollectionViewDiffableDataSource<Section, SimpleMovieInfo>!
    var movieList: [SimpleMovieInfo] = []
//        SimpleMovieInfo(name: "광해: 왕이 된 남자", inset: "1", audience: "934만", release: "20120303", oldAndNew: .old),
//        SimpleMovieInfo(name: "극한직업", inset: "2", audience: "834만", release: "20253503", oldAndNew: .old),
//        SimpleMovieInfo(name: "탑건: 메브릭", inset: "3", audience: "734만", release: "20230303", oldAndNew: .old),
//        SimpleMovieInfo(name: "어벤져스: 인피니티 워", inset: "4", audience: "534만", release: "20190303", oldAndNew: .old),
//        SimpleMovieInfo(name: "타이타닉", inset: "0", audience: "4342", release: "20120303", oldAndNew: .new),
//        SimpleMovieInfo(name: "태극기 휘날리며", inset: "-1", audience: "934만", release: "20120303", oldAndNew: .old),
//        SimpleMovieInfo(name: "쇼생크 탈출", inset: "2", audience: "834만", release: "20253503", oldAndNew: .old),
//        SimpleMovieInfo(name: "수리남", inset: "-3", audience: "734만", release: "20230303", oldAndNew: .old),
//        SimpleMovieInfo(name: "베테랑", inset: "4", audience: "534만", release: "20190303", oldAndNew: .old),
//        SimpleMovieInfo(name: "어바웃타임", inset: "5", audience: "4342", release: "20120303", oldAndNew: .new)
    

    
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
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<MovieCollectionViewCell, SimpleMovieInfo> { cell, indexPath, movie in
            Task {
                cell.rankingLabel.text = "\(movie.rank)"
                do {
                    cell.posterImageView.image = try await NetworkManager.shared.getPosterImage(englishName: movie.englishName)
                } catch {
                    print(error.localizedDescription)
                }
                if movie.inset.first == "-" {
                    cell.rankingChangeButton.tintColor = .systemBlue
                    cell.rankingChangeButton.setImage(UIImage(systemName: "arrow.down"), for: .normal)
                    cell.rankingChangeButton.setTitle(String(movie.inset.last!), for: .normal)
                } else if movie.inset == "0" {
                    cell.rankingChangeButton.tintColor = .white
                    cell.rankingChangeButton.setImage(UIImage(systemName: "minus"), for: .normal)
                    cell.rankingChangeButton.setTitle(movie.inset, for: .normal)
                } else {
                    cell.rankingChangeButton.tintColor = .systemRed
                    cell.rankingChangeButton.setImage(UIImage(systemName: "arrow.up"), for: .normal)
                    cell.rankingChangeButton.setTitle(movie.inset, for: .normal)
                }
                if movie.oldAndNew == .new {
                    cell.newButton.isHidden = false
                } else {
                    cell.newButton.isHidden = true
                }
                cell.movieNameLabel.text = movie.name
                cell.releaseDateLabel.text = "개봉일 : " + movie.release
                cell.audienceLabel.text = "총 관객 : " + movie.audience
            }
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, SimpleMovieInfo>(collectionView: self.movieRankView.collectionView) { collectionView, indexPath, video in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: video)
        }
    }
    
    
    private func getMovieRank() {
        let yesterday = Date(timeIntervalSinceNow: -86400).toString()
        var snapshot = NSDiffableDataSourceSnapshot<Section, SimpleMovieInfo>()
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

enum Section {
    case main
}
