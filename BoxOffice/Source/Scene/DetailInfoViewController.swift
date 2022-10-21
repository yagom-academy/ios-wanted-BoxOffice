//
//  DetailInfoViewController.swift
//  BoxOffice
//
//  Created by 권준상 on 2022/10/20.
//

import UIKit

typealias SecondSectionAndTitle = (title: String, section: SecondSection)

class DetailInfoViewController: UIViewController {
    
    var shareItems = [String]()
    let detailInfoView = DetailInfoView()
    var simpleMovieInfo: SimpleMovieInfoEntity?
    var detailMovieInfo: DetailMovieInfoEntity?
    var standardInfoList: [StandardMovieInfoEntity] = []
    var sectionList: [SecondSectionAndTitle] = [("", .main), ("기본 정보", .standard), ("출연", .actors)]
    
    override func loadView() {
        view = detailInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setCollectionView()
        getMovieInfo()
    }
    
    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonDidTap))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonDidTap))
        navigationItem.leftBarButtonItem?.tintColor = .systemGray
        navigationItem.rightBarButtonItem?.tintColor = .systemGray
    }
    
    private func setCollectionView() {
        detailInfoView.collectionView.dataSource = self
        detailInfoView.collectionView.register(MainInfoCollectionViewCell.self, forCellWithReuseIdentifier: MainInfoCollectionViewCell.id)
        detailInfoView.collectionView.register(StandardInfoCollectionViewCell.self, forCellWithReuseIdentifier: StandardInfoCollectionViewCell.id)
        detailInfoView.collectionView.register(ActorCollectionViewCell.self, forCellWithReuseIdentifier: ActorCollectionViewCell.id)
        detailInfoView.collectionView.register(SubjectReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SubjectReusableView.id)
        detailInfoView.collectionView.collectionViewLayout = createBasicListLayout()
    }
    
    
    private func getMovieInfo() {
        Task {
            do {
                var data = try await NetworkManager.shared.getDetailMovieInfo(movieCd: simpleMovieInfo!.movieId)
                data.simpleInfo = simpleMovieInfo
                self.detailMovieInfo = data
                standardInfoList.removeAll()
                standardInfoList.append(StandardMovieInfoEntity(title: "감독", value: data.directors))
                standardInfoList.append(StandardMovieInfoEntity(title: "상영 시간", value: data.showTime + "분"))
                standardInfoList.append(StandardMovieInfoEntity(title: "연령 등급", value: data.watchGrade))
                standardInfoList.append(StandardMovieInfoEntity(title: "개봉일", value: data.openYear))
                standardInfoList.append(StandardMovieInfoEntity(title: "총 관객", value: data.simpleInfo!.audience + "명"))
                standardInfoList.append(StandardMovieInfoEntity(title: "제작 연도", value: data.productYear + "년"))
            } catch {
                print(error.localizedDescription)
            }
            await MainActor.run {
                detailInfoView.collectionView.reloadData()
            }
        }
    }
    
    private func createBasicListLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let sectionName = self.sectionList[sectionIndex].section
            switch sectionName {
            case .main:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .estimated(250))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitem: item, count: 1)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .none
                
                return section
            case .standard:
                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(60),
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(2),
                                                       heightDimension: .estimated(100))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitem: item, count: 6)
                group.interItemSpacing = .fixed(CGFloat(10))
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = .init(top: 8, leading: 8, bottom: 18, trailing: 8)
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                
                return section
            case .actors:
                let actorCount = self.detailMovieInfo?.actors.count ?? 1
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .estimated(CGFloat(actorCount) * 50))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                             subitem: item, count: (actorCount == 0 ? 1 : actorCount))
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .none
                section.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                
                return section
            }
        }
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        return .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
    
    private func setTextData(_ movie: DetailMovieInfoEntity) {
        shareItems.append("영화 : " + movie.simpleInfo!.name + "\n")
        shareItems.append("개봉 날짜 : " + movie.simpleInfo!.release + "\n")
        shareItems.append("총 관객 : " + movie.simpleInfo!.audience + "\n")
        shareItems.append("감독 : " + movie.directors + "\n")
        shareItems.append("상영시간 : " + movie.showTime + "\n")
        shareItems.append("연령 등급 : " + movie.watchGrade + "\n")
        shareItems.append("제작 연도 : " + movie.productYear + "\n")
    }
    
    @objc func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func shareButtonDidTap() {
        let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
}

extension DetailInfoViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sectionList[section].section {
        case .main:
            return detailMovieInfo == nil ? 0 : 1
        case .standard:
            return standardInfoList.count
        case .actors:
            return detailMovieInfo == nil ? 0 : detailMovieInfo?.actors.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sectionList[indexPath.section].section {
        case .main:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainInfoCollectionViewCell.id, for: indexPath) as? MainInfoCollectionViewCell else { return UICollectionViewCell() }
            guard let movie = self.detailMovieInfo else { return UICollectionViewCell() }
            Task {
                do {
                    cell.posterImageView.image = try await NetworkManager.shared.getPosterImage(englishName: movie.simpleInfo?.englishName ?? "")
                } catch {
                    print(error.localizedDescription)
                }
                cell.setData(movie)
                setTextData(movie)
            }
            return cell
        case .standard:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StandardInfoCollectionViewCell.id, for: indexPath) as? StandardInfoCollectionViewCell else { return UICollectionViewCell() }
            cell.setData(data: standardInfoList[indexPath.item])
            return cell
        case .actors:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorCollectionViewCell.id, for: indexPath) as? ActorCollectionViewCell else { return UICollectionViewCell() }
            if let title = detailMovieInfo?.actors[indexPath.item] {
                cell.setData(title: title)
            }
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SubjectReusableView.id, for: indexPath) as? SubjectReusableView else { return UICollectionReusableView() }
            header.setData(title: self.sectionList[indexPath.section].title)
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    
}

enum SecondSection {
    case main
    case standard
    case actors
}
