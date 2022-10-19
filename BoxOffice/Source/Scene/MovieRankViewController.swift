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
    var movieList: [SimpleMovieInfo] = [
        SimpleMovieInfo(image: "mas", name: "광해: 왕이 된 남자", inset: "1", audience: "934만", release: "20120303", oldAndNew: .old),
        SimpleMovieInfo(image: "mas", name: "극한직업", inset: "2", audience: "834만", release: "20253503", oldAndNew: .old),
        SimpleMovieInfo(image: "mas", name: "탑건: 메브릭", inset: "3", audience: "734만", release: "20230303", oldAndNew: .old),
        SimpleMovieInfo(image: "mas", name: "어벤져스: 인피니티 워", inset: "4", audience: "534만", release: "20190303", oldAndNew: .old),
        SimpleMovieInfo(image: "mas", name: "타이타닉", inset: "0", audience: "4342", release: "20120303", oldAndNew: .new),
        SimpleMovieInfo(image: "mas", name: "태극기 휘날리며", inset: "-1", audience: "934만", release: "20120303", oldAndNew: .old),
        SimpleMovieInfo(image: "mas", name: "쇼생크 탈출", inset: "2", audience: "834만", release: "20253503", oldAndNew: .old),
        SimpleMovieInfo(image: "mas", name: "수리남", inset: "-3", audience: "734만", release: "20230303", oldAndNew: .old),
        SimpleMovieInfo(image: "mas", name: "베테랑", inset: "4", audience: "534만", release: "20190303", oldAndNew: .old),
        SimpleMovieInfo(image: "mas", name: "어바웃타임", inset: "5", audience: "4342", release: "20120303", oldAndNew: .new)]

    
    override func loadView() {
        view = movieRankView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        performQuery()
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<MovieCollectionViewCell, SimpleMovieInfo> { cell, indexPath, movie in
            cell.rankingLabel.text = "\(indexPath.item + 1)"
            cell.posterImageView.image = UIImage(named: movie.image)
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
            cell.movieNameLabel.text = movie.name
            cell.releaseDateLabel.text = movie.release
            cell.audienceLabel.text = movie.audience
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, SimpleMovieInfo>(collectionView: self.movieRankView.collectionView) { collectionView, indexPath, video in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: video)
        }
    }
    
    private func performQuery() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, SimpleMovieInfo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movieList)
        self.dataSource.apply(snapshot, animatingDifferences: true)

    }


}

enum Section {
    case main
}

struct SimpleMovieInfo: Hashable {
    var image: String
    var name: String
    var inset: String
    var audience: String
    var release: String
    var oldAndNew: RankOldAndNew
}
