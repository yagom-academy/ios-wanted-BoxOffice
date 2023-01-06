//
//  BoxOfficeListView.swift
//  BoxOffice
//
//  Created by dhoney96 on 2023/01/03.
//

import UIKit

class BoxOfficeListView: UIView {
    // MARK: properties
    let typeLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.text = "\(DateFormatterManager.shared.convertToDateTitle()) 순위"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let boxOfficeCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        configureView()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private function
    private func configureView() {
        self.addSubview(typeLabel)
        self.addSubview(boxOfficeCollectionView)
    }
    
    private func configureUI() {
        NSLayoutConstraint.activate([
            self.typeLabel.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor,
                constant: 10
            ),
            self.typeLabel.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                constant: 10
            ),
            
            self.boxOfficeCollectionView.topAnchor.constraint(
                equalTo: self.typeLabel.bottomAnchor,
                constant: 10
            ),
            self.boxOfficeCollectionView.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor
            ),
            self.boxOfficeCollectionView.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor
            ),
            self.boxOfficeCollectionView.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor
            )
        ])
    }
}
