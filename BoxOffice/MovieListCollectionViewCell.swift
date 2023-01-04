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
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "image.fill")
        imageView.backgroundColor = .systemGray4
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
        
    private let rankValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        return label
    }()
    
    private let openingDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "개봉일"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let openingDayValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        return label
    }()
    
    private let audienceNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "관객수"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let audienceNumberValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        return label
    }()
    
    private let rankFluctuationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "순위변동"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let rankFluctuationValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        return label
    }()
    
    private let newlyRankedLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        return label
    }()
    
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
