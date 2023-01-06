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
    
    private let productionYearLabel = MovieLabel(font: .title3, isBold: true)
    private var ageLimitLabel = MovieLabel(font: .title3, isBold: true)
    private let showTimeLabel = MovieLabel(font: .title3, isBold: true)
    private let totalAudienceLabel = MovieLabel(font: .title3, isBold: true)
    private let directorNameLabel = MovieLabel(font: .body)
    private let actorsLabel = MovieLabel(font: .body)
    
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
        separator.lineWidth = 16
        UIColor.systemGray5.setStroke()
        separator.stroke()
        separator.close()
    }
    
    //TODO: MovieDetail로 뷰 세팅하기
    func configure(with movie: MovieDetail) {
        if let ageLimit = AgeLimit(rawValue: movie.ageLimit) {
            ageLimitLabel.text = ageLimit.age
            ageLimitLabel.backgroundColor = ageLimit.color
        } else {
            ageLimitLabel.text = AgeLimit.fullLimit.age
            ageLimitLabel.backgroundColor = AgeLimit.fullLimit.color
        }
        
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

enum AgeLimit: String {
    case all = "전체관람가"
    case twelveOver = "12세 이상 관람가"
    case fifteenOver = "15세 이상 관람가"
    case teenagersNotAllowed = "청소년 관람불가"
    case fullLimit = "제한상영가"
    
    var age: String {
        switch self {
        case .all:
            return "All"
        case .twelveOver:
            return "12"
        case .fifteenOver:
            return "15"
        case .teenagersNotAllowed:
            return "18"
        case .fullLimit:
            return "X"
        }
    }
    
    var color: UIColor {
        switch self {
        case .all:
            return .systemGreen
        case .twelveOver:
            return .systemYellow
        case .fifteenOver:
            return .systemOrange
        case .teenagersNotAllowed:
            return .systemRed
        case .fullLimit:
            return .black
        }
    }
}
