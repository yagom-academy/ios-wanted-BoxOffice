//
//  MovieCollectionViewCell.swift
//  BoxOffice
//
//  Created by 권준상 on 2022/10/19.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let darkBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.layer.cornerRadius = 2
        return view
    }()
    
    let rankingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.layer.zPosition = 1
        return label
    }()
    
    private let rankStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var rankingChangeButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 20)
        button.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.setTitleColor(.systemBackground, for: .normal)
        button.layer.zPosition = 1
        return button
    }()
    
    let newButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setTitle("New", for: .normal)
        button.isHidden = true
        return button
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        return stackView
    }()
    
    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 19, weight: .bold)
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    let audienceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayouts()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rankingLabel.text = ""
        rankingChangeButton.titleLabel?.text = ""
        newButton.isHidden = true
        movieNameLabel.text = ""
        releaseDateLabel.text = ""
        audienceLabel.text = ""
    }
    
    private func setLayouts() {
        setProperties()
        setViewHierarchy()
        setConstraints()
    }
    
    private func setProperties() {
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }

    private func setViewHierarchy() {
        contentView.addSubviews(posterImageView, infoStackView)
        posterImageView.addSubviews(darkBackgroundView)
        darkBackgroundView.addSubviews(rankStackView)
        rankStackView.addArrangedSubviews(
            rankingLabel,
            rankingChangeButton
        )
        infoStackView.addArrangedSubviews(
            movieNameLabel,
            releaseDateLabel,
            audienceLabel)
    }

    private func setConstraints() {
        [posterImageView, infoStackView, darkBackgroundView, rankStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            posterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 150),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 1.43),
            
            darkBackgroundView.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 5),
            darkBackgroundView.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: 5),
            
            rankStackView.topAnchor.constraint(equalTo: darkBackgroundView.topAnchor, constant: 5),
            rankStackView.leadingAnchor.constraint(equalTo: darkBackgroundView.leadingAnchor, constant: 5),
            rankStackView.trailingAnchor.constraint(equalTo: darkBackgroundView.trailingAnchor, constant: -5),
            rankStackView.bottomAnchor.constraint(equalTo: darkBackgroundView.bottomAnchor, constant: -5),
            
            infoStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
    }
}
