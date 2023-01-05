//
//  MovieMainInfoCollectionViewCell.swift
//  BoxOffice
//
//  Created by Judy on 2023/01/05.
//

import UIKit

class MovieMainInfoView: UIView {
    private let rankStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let openYearStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let entireStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let posterView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let starView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .systemYellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let ratingLabel = MovieLabel(font: .headline)
    private let titleLabel = MovieLabel(font: .largeTitle)
    private let currentRanklabel = MovieLabel(font: .caption1)
    private let rankChangeLabel = MovieLabel(font: .caption1)
    private let isNewEntryLabel = MovieLabel(font: .caption1)
    private let openYearLabel = MovieLabel(font: .callout)
    private let genreLabel = MovieLabel(font: .callout)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func configure(with movie: MovieDetail) {
        //TODO: 별점 평균내기
        ratingLabel.text = "4.5"
        titleLabel.text = movie.title
        currentRanklabel.text = movie.currentRank
        rankChangeLabel.text = movie.rankChange
        isNewEntryLabel.text = "\(movie.isNewEntry)"
        openYearLabel.text = movie.openYear
        genreLabel.text = movie.genreName
    }
    
    private func setupView() {
        addSubView()
        setupConstraint()
    }
    
    private func addSubView() {
        rankStackView.addArrangedSubview(currentRanklabel)
        rankStackView.addArrangedSubview(rankChangeLabel)
        rankStackView.addArrangedSubview(isNewEntryLabel)
        
        openYearStackView.addArrangedSubview(openYearLabel)
        openYearStackView.addArrangedSubview(genreLabel)
        
        ratingStackView.addArrangedSubview(starView)
        ratingStackView.addArrangedSubview(currentRanklabel)
        
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(rankStackView)
        infoStackView.addArrangedSubview(openYearStackView)
        infoStackView.addArrangedSubview(ratingStackView)
        
        self.addSubview(posterView)
        self.addSubview(infoStackView)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            entireStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
                                                 constant: 8),
            entireStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                                 constant: -8),
            entireStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                                 constant: 16),
            entireStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -16)
        ])
    }
    
}
