//
//  MovieMainInfoCollectionViewCell.swift
//  BoxOffice
//
//  Created by Judy on 2023/01/05.
//

import UIKit

final class MovieMainInfoView: UIView {
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
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let posterView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray6
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
    
    private let titleLabel = MovieLabel(font: .title1, isBold: true)
    private let currentRanklabel = MovieLabel(font: .callout)
    private let rankChangeLabel = MovieLabel(font: .callout)
    private let isNewEntryLabel = MovieLabel(font: .callout)
    private let openYearLabel = MovieLabel(font: .body)
    private let genreLabel = MovieLabel(font: .body)
    private let ratingLabel = MovieLabel(font: .headline)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func draw(_ rect: CGRect) {
        let separator = UIBezierPath()
        separator.move(to: CGPoint(x: 0, y: bounds.maxY))
        separator.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        separator.lineWidth = 8
        UIColor.systemGray5.setStroke()
        separator.stroke()
        separator.close()
    }
    
    //TODO: 정보 표시 형식 맞추기
    func configure(with movie: MovieData) {
        //TODO: 포스터 이미지로 변경
        posterView.image = UIImage(systemName: "camera")
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
        titleLabel.numberOfLines = 0
        self.backgroundColor = .systemBackground
    }
    
    private func addSubView() {
        rankStackView.addArrangedSubview(currentRanklabel)
        rankStackView.addArrangedSubview(rankChangeLabel)
        rankStackView.addArrangedSubview(isNewEntryLabel)
        
        openYearStackView.addArrangedSubview(openYearLabel)
        openYearStackView.addArrangedSubview(genreLabel)
        
        ratingStackView.addArrangedSubview(starView)
        ratingStackView.addArrangedSubview(ratingLabel)
        
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(rankStackView)
        infoStackView.addArrangedSubview(openYearStackView)
        infoStackView.addArrangedSubview(ratingStackView)
        
        entireStackView.addArrangedSubview(posterView)
        entireStackView.addArrangedSubview(infoStackView)
        
        self.addSubview(entireStackView)
    }
    
    //TODO: constraint 및 StackView 조정
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            entireStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
                                                 constant: 8),
            entireStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                                 constant: -8),
            entireStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                                 constant: 16),
            entireStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -16),
            
            posterView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor,
                                              multiplier: 4/10)
        ])
    }
    
}
