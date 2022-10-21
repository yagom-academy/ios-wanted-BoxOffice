//
//  MovieCollectionViewCell.swift
//  BoxOffice
//
//  Created by 권준상 on 2022/10/19.
//

import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let darkBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.layer.cornerRadius = 2
        return view
    }()
    
    private let rankingLabel: UILabel = {
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
    
    private lazy var rankingChangeButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 20)
        button.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.setTitleColor(.systemBackground, for: .normal)
        button.layer.zPosition = 1
        return button
    }()
    
    private let newButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.setTitleColor(.systemRed, for: .normal)
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
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let audienceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14)
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
        posterImageView.image = nil
        rankingLabel.text = ""
        rankingChangeButton.titleLabel?.text = ""
        newButton.isHidden = true
        movieNameLabel.text = ""
        releaseDateLabel.text = ""
        audienceLabel.text = ""
    }
    
    func setData(_ movie: SimpleMovieInfoEntity) {
        rankingLabel.text = "\(movie.rank)"
        if movie.inset.first == "-" {
            rankingChangeButton.tintColor = .systemBlue
            rankingChangeButton.setImage(UIImage(systemName: "arrow.down"), for: .normal)
            rankingChangeButton.setTitle(String(movie.inset.last!), for: .normal)
        } else if movie.inset == "0" {
            rankingChangeButton.tintColor = .white
            rankingChangeButton.setImage(UIImage(systemName: "minus"), for: .normal)
            rankingChangeButton.setTitle(movie.inset, for: .normal)
        } else {
            rankingChangeButton.tintColor = .systemRed
            rankingChangeButton.setImage(UIImage(systemName: "arrow.up"), for: .normal)
            rankingChangeButton.setTitle(movie.inset, for: .normal)
        }
        if movie.oldAndNew == .new {
            newButton.isHidden = false
        } else {
            newButton.isHidden = true
        }
        movieNameLabel.text = movie.name
        releaseDateLabel.text = "개봉일 : " + movie.release
        audienceLabel.text = "총 관객 : " + movie.audience
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
        posterImageView.addSubviews(darkBackgroundView, newButton)
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
        [posterImageView, infoStackView, darkBackgroundView, rankStackView, newButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            posterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 150),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 1.43),
            
            darkBackgroundView.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 5),
            darkBackgroundView.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: 5),
            
            newButton.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -5),
            newButton.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -5),
            
            rankStackView.topAnchor.constraint(equalTo: darkBackgroundView.topAnchor, constant: 5),
            rankStackView.leadingAnchor.constraint(equalTo: darkBackgroundView.leadingAnchor, constant: 5),
            rankStackView.trailingAnchor.constraint(equalTo: darkBackgroundView.trailingAnchor, constant: -5),
            rankStackView.bottomAnchor.constraint(equalTo: darkBackgroundView.bottomAnchor, constant: -5),
            
            infoStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 5),
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
    }
}
