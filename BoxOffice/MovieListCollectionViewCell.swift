//
//  MovieListCollectionViewCell.swift
//  BoxOffice
//
//  Created by minsson on 2023/01/03.
//

import UIKit

final class MovieListCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "movieListCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
