//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

enum Section {
    case main
}

class MainViewController: UIViewController {
    var boxOfficeCollectionView: UICollectionView!
    var boxOfficeDatasource: UICollectionViewDiffableDataSource<Section, DailyBoxOfficeList>!
    var boxOfficeData: [DailyBoxOffice] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager().getBoxOfficeData { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.createBoxOfficeCollectionView()
                    self.configBoxOfficeDataSource(data: success.boxOfficeResult.dailyBoxOfficeList)
                    self.boxOfficeCollectionView.reloadData()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        print(DateManager().getCurrentDate())
    }
}

extension MainViewController {
    func createBoxOfficeLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    func createBoxOfficeCollectionView() {
        boxOfficeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createBoxOfficeLayout())
        self.view.addSubview(boxOfficeCollectionView)
        
        NSLayoutConstraint.activate([
            boxOfficeCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            boxOfficeCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            boxOfficeCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            boxOfficeCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    func configBoxOfficeDataSource(data: [DailyBoxOfficeList]) {
        let cellRegistration = UICollectionView.CellRegistration<BoxOfficeCollectionViewCell, DailyBoxOfficeList> { cell, indexPath, data in
            cell.configBoxOfficeCell(data: data)
        }
        
        boxOfficeDatasource = UICollectionViewDiffableDataSource<Section, DailyBoxOfficeList>(collectionView: boxOfficeCollectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        var snapShot = NSDiffableDataSourceSnapshot<Section, DailyBoxOfficeList>()
        snapShot.appendSections([.main])
        snapShot.appendItems(data)
        boxOfficeDatasource.apply(snapShot)
    }
}
