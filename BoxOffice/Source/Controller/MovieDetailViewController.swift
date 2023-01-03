//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by seohyeon park on 2023/01/02.
//

import UIKit

class MovieDetailViewController: UIViewController {
    let movieDetailView = MovieDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(movieDetailView)
        
        NSLayoutConstraint.activate([
            movieDetailView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            movieDetailView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            movieDetailView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            movieDetailView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        movieDetailView.nameCollectionView.delegate = self
        movieDetailView.nameCollectionView.dataSource = self
        
        movieDetailView.nameCollectionView.register(MembersCollectionViewCell.self, forCellWithReuseIdentifier: "MembersCollectionViewCell")
    }
}


extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "MembersCollectionViewCell",
            for: indexPath
        ) as? MembersCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}

extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let tempLabel = UILabel()
        tempLabel.text = "이름이름이름이름"
        return CGSize(
            width: tempLabel.intrinsicContentSize.width,
            height: movieDetailView.nameCollectionView.frame.height
        )
    }
}
