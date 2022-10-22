//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

typealias FirstSectionAndTitle = (title: String, section: FirstSection)

final class MovieRankViewController: UIViewController {
    
    private let movieRankView = MovieRankView()
    private var dataSource: UICollectionViewDiffableDataSource<FirstSection, SimpleMovieInfoEntity>!
    private var dailyMovieList: [SimpleMovieInfoEntity] = []
    private var weekendMovieList: [SimpleMovieInfoEntity] = []
    private var weekDay: [String] = ["월", "화", "수", "목", "금"]
    private var sectionList: [FirstSectionAndTitle] = [("일별 박스오피스 순위", .daily), ("주말 박스오피스 순위", .weekend)]
    
    
    override func loadView() {
        view = movieRankView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        configureDataSource()
        getMovieRank()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        self.navigationItem.title = "BoxOffice"
        self.navigationController?.navigationBar.prefersLargeTitles = true
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
                    cell.posterImageView.image = UIImage(systemName: "video.fill")
                    print(error.localizedDescription)
                }
                cell.setData(movie)
            }
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <BigSubjectReusableView>(elementKind: UICollectionView.elementKindSectionHeader) {
            supplementaryView, string, indexPath in
            supplementaryView.setData(title: self.sectionList[indexPath.section].title)
            supplementaryView.backgroundColor = .systemBackground
        }
        
        dataSource = UICollectionViewDiffableDataSource<FirstSection, SimpleMovieInfoEntity>(collectionView: self.movieRankView.collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, video: SimpleMovieInfoEntity) -> UICollectionViewCell? in
            guard let sectionIdentifier = self.dataSource.snapshot().sectionIdentifier(containingItem: video) else {
                return nil
            }
            switch sectionIdentifier {
            case .daily:
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: video)
            case .weekend:
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: video)
            }
            
        }
        
        self.dataSource.supplementaryViewProvider = { supplementaryView, elementKind, indexPath in
            return self.movieRankView.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
    }
    
    
    private func getMovieRank() {
        let yesterday = Date(timeIntervalSinceNow: -86400).toString()
        var weekendDay = yesterday
        let yesterdayOfWeek = Date(timeIntervalSinceNow: -86400).toDay()
        if weekDay.contains(yesterdayOfWeek) {
            let num = weekDay.firstIndex(of: yesterdayOfWeek)! + 2
            weekendDay = Date(timeIntervalSinceNow: -(86400 * Double(num))).toString()
        }
        var snapshot = NSDiffableDataSourceSnapshot<FirstSection, SimpleMovieInfoEntity>()
        
        Task {
            snapshot.appendSections([.daily])
            
            do {
                let dailyData = try await NetworkManager.shared.getDailyMovieRank(date: yesterday)
                self.dailyMovieList = dailyData
            } catch {
                print(error.localizedDescription)
            }
            await MainActor.run {
                self.dailyMovieList.sort(by: {$0.rank < $1.rank})
                snapshot.appendItems(dailyMovieList)
            }
            
            snapshot.appendSections([.weekend])
            
            do {
                let weekendData = try await NetworkManager.shared.getWeekendMovieRank(date: weekendDay)
                self.weekendMovieList = weekendData
            } catch {
                print(error.localizedDescription)
            }
            await MainActor.run {
                self.weekendMovieList.sort(by: {$0.rank < $1.rank})
                snapshot.appendItems(weekendMovieList)
            }
            
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
    
    private func createBasicListLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) ->
            NSCollectionLayoutSection? in
            let sectionIdentifier = self.dataSource.snapshot().sectionIdentifiers[sectionIndex]
            switch sectionIdentifier {
            case .daily:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
              
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(5.0),
                                                      heightDimension: .estimated(320))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitem: item, count: 10)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                section.contentInsets = .init(top: 0, leading: 5, bottom: 20, trailing: 5)
                return section
            case .weekend:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
              
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(5.0),
                                                      heightDimension: .estimated(320))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitem: item, count: 10)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                section.contentInsets = .init(top: 0, leading: 5, bottom: 20, trailing: 5)
                return section
            }
        }
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        return .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }

}

extension MovieRankViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        let detailInfoViewController = DetailInfoViewController()
        switch indexPath.section {
        case 0:
            let movie = dailyMovieList[indexPath.item]
            detailInfoViewController.simpleMovieInfo = movie
            self.navigationController?.pushViewController(detailInfoViewController, animated: true)
        case 1:
            let movie = weekendMovieList[indexPath.item]
            detailInfoViewController.simpleMovieInfo = movie
            self.navigationController?.pushViewController(detailInfoViewController, animated: true)
        default:
            return
        }
        
    }
}

enum FirstSection {
    case daily
    case weekend
}
