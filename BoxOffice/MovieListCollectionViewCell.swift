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
        
        addViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = UIImage()
        titleLabel.text = ""
        rankValueLabel.text = ""
        newlyRankedLabel.text = ""
        
        audienceNumberValueLabel.text = ""
        openingDayValueLabel.text = ""
        
        rankFluctuationValueLabel.text = ""
    }
    
    func setupContents(movieOverview: MovieOverview) {
        movieCode = movieOverview.movieCode
        dayType = movieOverview.dayType
        region = movieOverview.region
        
        titleLabel.text = movieOverview.title
        rankValueLabel.text = "\(movieOverview.rank)"
        newlyRankedLabel.text = movieOverview.isNewlyRanked ? "New" : ""
        audienceNumberValueLabel.text = "\(movieOverview.audienceNumber)"
        openingDayValueLabel.text = "\(movieOverview.openingDay)"
        
        if movieOverview.rankFluctuation > 0 {
            rankFluctuationValueLabel.text = "▲ \(movieOverview.rankFluctuation)"
            rankFluctuationValueLabel.textColor = .red
        } else if movieOverview.rankFluctuation < 0 {
            rankFluctuationValueLabel.text = "▼ \(-movieOverview.rankFluctuation)"
            rankFluctuationValueLabel.textColor = .blue
        } else {
            rankFluctuationValueLabel.text = ""
            rankFluctuationValueLabel.textColor = .secondaryLabel
        }
    }
    
    private func addViews() {
        [
            imageView,
            titleLabel,
            rankValueLabel,
            openingDayLabel,
            openingDayValueLabel,
            audienceNumberLabel,
            audienceNumberValueLabel,
            rankFluctuationLabel,
            rankFluctuationValueLabel,
            newlyRankedLabel
        ].forEach { addSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constraint.outerSpacing),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constraint.outerSpacing),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constraint.outerSpacing),
            imageView.widthAnchor.constraint(equalToConstant: Constraint.imageViewWidth),
            imageView.heightAnchor.constraint(equalToConstant: Constraint.imageViewHeight),
            
            rankValueLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: Constraint.innerSpacing),
            rankValueLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: Constraint.innerSpacing),

            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constraint.innerSpacing),
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            
            newlyRankedLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            newlyRankedLabel.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: Constraint.innerSpacing),
            newlyRankedLabel.bottomAnchor.constraint(equalTo: rankFluctuationLabel.topAnchor, constant: -Constraint.innerSpacing),
            
            rankFluctuationLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            rankFluctuationLabel.bottomAnchor.constraint(equalTo: audienceNumberLabel.topAnchor, constant: -Constraint.innerSpacing),

            rankFluctuationValueLabel.leadingAnchor.constraint(equalTo: rankFluctuationLabel.trailingAnchor, constant: Constraint.innerSpacing),
            rankFluctuationValueLabel.topAnchor.constraint(equalTo: rankFluctuationLabel.topAnchor),
            
            audienceNumberLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            audienceNumberLabel.bottomAnchor.constraint(equalTo: openingDayLabel.topAnchor, constant: -Constraint.innerSpacing),

            audienceNumberValueLabel.leadingAnchor.constraint(equalTo: audienceNumberLabel.trailingAnchor, constant: Constraint.innerSpacing),
            audienceNumberValueLabel.topAnchor.constraint(equalTo: audienceNumberLabel.topAnchor),
            
            openingDayLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            openingDayLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            
            openingDayValueLabel.leadingAnchor.constraint(equalTo: openingDayLabel.trailingAnchor, constant: Constraint.innerSpacing),
            openingDayValueLabel.topAnchor.constraint(equalTo: openingDayLabel.topAnchor),
        ])
    }
}

private extension MovieListCollectionViewCell {
    enum Constraint {
        static let innerSpacing: CGFloat = 8
        static let outerSpacing: CGFloat = 16
        static let imageViewWidth: CGFloat = 120
        static let imageViewHeight: CGFloat = 160
    }
}
