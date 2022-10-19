//
//  MovieRankView.swift
//  BoxOffice
//
//  Created by 권준상 on 2022/10/19.
//

import UIKit

class MovieRankView: UIView {
    
    private let boxOfficeLabel: UILabel = {
        let label = UILabel()
        label.text = "일별 박스오피스 순위"
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 23, weight: .bold)
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createBasicListLayout())
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayouts()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createBasicListLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(5.0),
                                              heightDimension: .estimated(320))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitem: item, count: 10)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func setLayouts() {
        self.backgroundColor = .systemBackground
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        addSubviews(boxOfficeLabel, collectionView)
    }

    private func setConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        [boxOfficeLabel, collectionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            boxOfficeLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            boxOfficeLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            collectionView.topAnchor.constraint(equalTo: boxOfficeLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: 400)
        ])
    }
    
}
