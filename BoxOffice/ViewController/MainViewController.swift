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
        setUiLayout()
    }
}

extension MainViewController {
    func setUiLayout() {
        NetworkManager().getBoxOfficeData { result in
            switch result {
            case .success(let boxOfficeData):
                DispatchQueue.main.sync {
                    self.createBoxOfficeCollectionView()
                    self.configBoxOfficeDataSource(data: boxOfficeData.boxOfficeResult.dailyBoxOfficeList)
                    self.boxOfficeCollectionView.reloadData()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func createBoxOfficeLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(135), heightDimension: .absolute(self.view.frame.height * 0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        group.interItemSpacing = .fixed(5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = CGFloat(5)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 0)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        
        return layout
    }
    
    func createBoxOfficeCollectionView() {
        boxOfficeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createBoxOfficeLayout())
        self.view.addSubview(boxOfficeCollectionView)

        boxOfficeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            boxOfficeCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            boxOfficeCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            boxOfficeCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            boxOfficeCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
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
