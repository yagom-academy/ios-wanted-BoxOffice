//
//  MainInfoCollectionViewCell.swift
//  BoxOffice
//
//  Created by 권준상 on 2022/10/20.
//

import UIKit

final class MainInfoCollectionViewCell: UICollectionViewCell {
    static let id = "MAIN"

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
    
    private let infoMainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }()
    
    private let infoSubStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
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
    
    private let openYearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let genreNameLabel: UILabel = {
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
        openYearLabel.text = ""
        genreNameLabel.text = ""
    }
    
    func setData(_ movie: DetailMovieInfoEntity) {
        if let rank = movie.simpleInfo?.rank {
            rankingLabel.text = "\(rank)"
        }
        if movie.simpleInfo?.inset.first == "-" {
            rankingChangeButton.tintColor = .systemBlue
            rankingChangeButton.setImage(UIImage(systemName: "arrow.down"), for: .normal)
            rankingChangeButton.setTitle(String(movie.simpleInfo?.inset.last! ?? Character("")), for: .normal)
        } else if movie.simpleInfo?.inset == "0" {
            rankingChangeButton.tintColor = .white
            rankingChangeButton.setImage(UIImage(systemName: "minus"), for: .normal)
            rankingChangeButton.setTitle(movie.simpleInfo?.inset, for: .normal)
        } else {
            rankingChangeButton.tintColor = .systemRed
            rankingChangeButton.setImage(UIImage(systemName: "arrow.up"), for: .normal)
            rankingChangeButton.setTitle(movie.simpleInfo?.inset, for: .normal)
        }
        if movie.simpleInfo?.oldAndNew == .new {
            newButton.isHidden = false
        } else {
            newButton.isHidden = true
        }
        movieNameLabel.text = movie.simpleInfo?.name
        openYearLabel.text = String(movie.openYear.prefix(4)) + " "
        var genreString = ""
        for i in 0..<movie.genreName.count {
            if i == movie.genreName.count - 1 {
                genreString += movie.genreName[i]
            } else {
                genreString += "\(movie.genreName[i]), "
            }
        }
        genreNameLabel.text = genreString
    }
    
    private func setLayouts() {
        setProperties()
        setViewHierarchy()
        setConstraints()
    }
    
    private func setProperties() {
        self.backgroundColor = .systemBackground
    }

    private func setViewHierarchy() {
        contentView.addSubviews(darkBackgroundView, posterImageView, infoMainStackView)
        darkBackgroundView.addSubviews(rankStackView)
        rankStackView.addArrangedSubviews(
            rankingLabel,
            rankingChangeButton,
            newButton)
        infoMainStackView.addArrangedSubviews(
            movieNameLabel,
            infoSubStackView)
        infoSubStackView.addArrangedSubviews(
            openYearLabel,
            genreNameLabel)
    }

    private func setConstraints() {
        [posterImageView, infoMainStackView, darkBackgroundView, rankStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            darkBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            darkBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            posterImageView.topAnchor.constraint(equalTo: darkBackgroundView.bottomAnchor, constant: 10),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            posterImageView.widthAnchor.constraint(equalToConstant: 100),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 1.43),
            
            rankStackView.topAnchor.constraint(equalTo: darkBackgroundView.topAnchor, constant: 5),
            rankStackView.leadingAnchor.constraint(equalTo: darkBackgroundView.leadingAnchor, constant: 5),
            rankStackView.trailingAnchor.constraint(equalTo: darkBackgroundView.trailingAnchor, constant: -5),
            rankStackView.bottomAnchor.constraint(equalTo: darkBackgroundView.bottomAnchor, constant: -5),
            
            infoMainStackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),
            infoMainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            infoMainStackView.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor)
        ])
        
    }
}
