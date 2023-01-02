//
//  MovieDetailInfoCollectionViewCell.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/02.
//

import UIKit

final class MovieDetailInfoCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "movieDetailInfoCollectionViewCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(movieDetail: MovieDetail) {

    }
}
