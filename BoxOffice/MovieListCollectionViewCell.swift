//
//  MovieListCollectionViewCell.swift
//  BoxOffice
//
//  Created by minsson on 2023/01/03.
//

import UIKit

final class MovieListCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "movieListCollectionViewCell"
    
    private var movieCode: String?
    private var dayType: DayType?
    private var region: Region?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
private extension MovieListCollectionViewCell {
    enum Constraint {
        static let innerSpacing: CGFloat = 8
        static let outerSpacing: CGFloat = 16
        static let imageViewWidth: CGFloat = 120
        static let imageViewHeight: CGFloat = 160
    }
}
