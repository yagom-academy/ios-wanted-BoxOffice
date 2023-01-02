//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/02.
//

import UIKit

final class MovieDetailViewController: UIViewController {

    private lazy var movieDetailCollectionView: UICollectionView = {
        let layout = movieDetailCollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func movieDetailCollectionViewLayout() -> UICollectionViewLayout {
        return UICollectionViewLayout()
    }
}
