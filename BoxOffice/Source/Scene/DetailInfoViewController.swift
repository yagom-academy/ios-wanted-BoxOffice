//
//  DetailInfoViewController.swift
//  BoxOffice
//
//  Created by 권준상 on 2022/10/20.
//

import UIKit

class DetailInfoViewController: UIViewController {
    
    let detailInfoView = DetailInfoView()
    var simpleMovieInfo: SimpleMovieInfoEntity?
    var detailMovieInfoList: [DetailMovieInfoEntity] = []
    private var dataSource: UICollectionViewDiffableDataSource<Section, DetailMovieInfoEntity>!
    
    override func loadView() {
        view = detailInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        configureDataSource()
        getMovieInfo()
    }
    
    private func setCollectionView() {
        detailInfoView.collectionView.collectionViewLayout = createBasicListLayout()
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<MainInfoCollectionViewCell, DetailMovieInfoEntity> { cell, indexPath, movie in
            Task {
                if let rank = movie.simpleInfo?.rank {
                    cell.rankingLabel.text = "\(rank)"
                }
                do {
                    cell.posterImageView.image = try await NetworkManager.shared.getPosterImage(englishName: movie.simpleInfo?.englishName ?? "")
                } catch {
                    print(error.localizedDescription)
                }
                if movie.simpleInfo?.inset.first == "-" {
                    cell.rankingChangeButton.tintColor = .systemBlue
                    cell.rankingChangeButton.setImage(UIImage(systemName: "arrow.down"), for: .normal)
                    cell.rankingChangeButton.setTitle(String(movie.simpleInfo?.inset.last! ?? Character("")), for: .normal)
                } else if movie.simpleInfo?.inset == "0" {
                    cell.rankingChangeButton.tintColor = .white
                    cell.rankingChangeButton.setImage(UIImage(systemName: "minus"), for: .normal)
                    cell.rankingChangeButton.setTitle(movie.simpleInfo?.inset, for: .normal)
                } else {
                    cell.rankingChangeButton.tintColor = .systemRed
                    cell.rankingChangeButton.setImage(UIImage(systemName: "arrow.up"), for: .normal)
                    cell.rankingChangeButton.setTitle(movie.simpleInfo?.inset, for: .normal)
                }
                if movie.simpleInfo?.oldAndNew == .new {
                    cell.newButton.isHidden = false
                } else {
                    cell.newButton.isHidden = true
                }
                cell.movieNameLabel.text = movie.simpleInfo?.name
                cell.openYearLabel.text = String(movie.openYear.prefix(4)) + " "
                var genreString = ""
                for i in 0..<movie.genreName.count {
                    if i == movie.genreName.count - 1 {
                        genreString += movie.genreName[i]
                    } else {
                        genreString += "\(movie.genreName[i]), "
                    }
                }
                cell.genreNameLabel.text = genreString
            }
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, DetailMovieInfoEntity>(collectionView: self.detailInfoView.collectionView) { collectionView, indexPath, video in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: video)
        }
    }
    
    
    private func getMovieInfo() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DetailMovieInfoEntity>()
        snapshot.appendSections([.main])
        Task {
            do {
                var data = try await NetworkManager.shared.getDetailMovieInfo(movieCd: simpleMovieInfo!.movieId)
                data.simpleInfo = simpleMovieInfo
                self.detailMovieInfoList.append(data)
            } catch {
                print(error.localizedDescription)
            }
            await MainActor.run {
                snapshot.appendItems(detailMovieInfoList)
                self.dataSource.apply(snapshot, animatingDifferences: true)
            }
        }
    }
    
    private func createBasicListLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(250))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
