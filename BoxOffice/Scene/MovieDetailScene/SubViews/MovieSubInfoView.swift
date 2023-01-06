//
//  MovieSubInfoCollectionViewCell.swift
//  BoxOffice
//
//  Created by Judy on 2023/01/05.
//

import UIKit

final class MovieSubInfoView: UIView {
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let actorStackView: UIStackView = {
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
    
    private let moreActorsButton: UIButton = {
        let button = UIButton()
        button.setTitle("더보기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let fakeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(greaterThanOrEqualToConstant: 10).isActive = true
        view.heightAnchor.constraint(greaterThanOrEqualToConstant: 10).isActive = true
        view.setContentHuggingPriority(.init(100), for: .horizontal)
        return view
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
        separator.lineWidth = 8
        UIColor.systemGray5.setStroke()
        separator.stroke()
        separator.close()
    }
    
    func configure(with movie: MovieData) {
        if let ageLimit = AgeLimit(rawValue: movie.ageLimit) {
            ageLimitLabel.text = ageLimit.age
            ageLimitLabel.backgroundColor = ageLimit.color
        } else {
            ageLimitLabel.text = AgeLimit.fullLimit.age
            ageLimitLabel.backgroundColor = AgeLimit.fullLimit.color
        }
        
        productionYearLabel.text = movie.productionYear + "년 제작"
        showTimeLabel.text = "•" + movie.showTime + "분"
        totalAudienceLabel.text = "•" + movie.totalAudience.toDecimal() + "명 관람"
        directorNameLabel.text = "감독: " + movie.directorName
        actorsLabel.text =  "출연: " + movie.actors.joined(separator: ", ")
    }
    
    func addTargetMoreButton(with target: UIViewController, selector: Selector) {
        moreActorsButton.addTarget(target,
                                   action: selector,
                                   for: .touchUpInside)
    }
    
    private func setupView() {
        addSubView()
        setupConstraint()
        self.backgroundColor = .systemBackground
    }
    
    private func addSubView() {
        infoStackView.addArrangedSubview(productionYearLabel)
        infoStackView.addArrangedSubview(ageLimitLabel)
        infoStackView.addArrangedSubview(showTimeLabel)
        infoStackView.addArrangedSubview(totalAudienceLabel)
        infoStackView.addArrangedSubview(fakeView)
        
        actorStackView.addArrangedSubview(actorsLabel)
        actorStackView.addArrangedSubview(moreActorsButton)
        
        entireStackView.addArrangedSubview(infoStackView)
        entireStackView.addArrangedSubview(directorNameLabel)
        entireStackView.addArrangedSubview(actorStackView)
        
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
    case twelveOver = "12세이상관람가"
    case fifteenOver = "15세이상관람가"
    case teenagersNotAllowed = "청소년관람불가"
    case fullLimit = "제한상영가"
    
    var age: String {
        switch self {
        case .all:
            return " ALL "
        case .twelveOver:
            return " 12 "
        case .fifteenOver:
            return " 15 "
        case .teenagersNotAllowed:
            return " 18 "
        case .fullLimit:
            return " X "
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
