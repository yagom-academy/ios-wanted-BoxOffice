//
//  MovieSubInfoCollectionViewCell.swift
//  BoxOffice
//
//  Created by Judy on 2023/01/05.
//

import UIKit

class MovieSubInfoView: UIView {
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let entireStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let totalAudienceLabel = MovieLabel(font: .title3)
    private let productionYearLabel = MovieLabel(font: .headline)
    private let showTimeLabel = MovieLabel(font: .headline)
    private let directorNameLabel = MovieLabel(font: .body)
    private let actorsLabel = MovieLabel(font: .body)
    private let ageLimitLabel = MovieLabel(font: .title3)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    //TODO: MovieDetail로 뷰 세팅하기
    func configure(with movie: MovieDetail) {
        totalAudienceLabel.text = movie.totalAudience
        productionYearLabel.text = movie.productionYear
        showTimeLabel.text = movie.showTime
        directorNameLabel.text = movie.directorName
        actorsLabel.text = movie.actors
        ageLimitLabel.text = movie.ageLimit
    }
    
    private func setupView() {
        addSubView()
        setupConstraint()
        self.backgroundColor = .systemBackground
    }
    
    private func addSubView() {
        horizontalStackView.addArrangedSubview(productionYearLabel)
        horizontalStackView.addArrangedSubview(ageLimitLabel)
        horizontalStackView.addArrangedSubview(showTimeLabel)
        horizontalStackView.addArrangedSubview(totalAudienceLabel)
        
        entireStackView.addArrangedSubview(horizontalStackView)
        entireStackView.addArrangedSubview(directorNameLabel)
        entireStackView.addArrangedSubview(actorsLabel)
        
        self.addSubview(entireStackView)
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
