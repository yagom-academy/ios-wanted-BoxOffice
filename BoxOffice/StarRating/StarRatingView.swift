//
//  StarRatingView.swift
//  BoxOffice
//
//  Created by Judy on 2023/01/03.
//

import UIKit

class StarRatingView: UIView {
    private let starImages = (1...5).map { _ in StarImageView(frame: .zero) }
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.text = "0.0"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: label.font.pointSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let starSlider: StarRatingUISlider = {
        let slider = StarRatingUISlider()
        slider.maximumValue = 5.0
        slider.minimumValue = 0.0
        slider.minimumTrackTintColor = .clear
        slider.maximumTrackTintColor = .clear
        slider.thumbTintColor = .clear
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private let starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let entireStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupStars(to rating: Float) {
        let ratingValue = Int(rating)
        let halfValue = rating - Float(ratingValue)

        if rating == Float.zero {
            clearStar(upto: 0)
            return
        }

        fillStar(upto: ratingValue)

        if halfValue != Float.zero {
            starImages[ratingValue].image = UIImage(systemName: "star.leadinghalf.fill")
        }
    }

    @objc private func sliderStar() {
        let rating = starSlider.value
        let downedRating = rating.rounded(.down)
        let halfRating = rating - downedRating
        let rateValue = Int(downedRating)

        fillStar(upto: rateValue)
        clearStar(upto: rateValue)

        if halfRating >= 0.5 {
            starImages[rateValue].image = UIImage(systemName: "star.leadinghalf.fill")
            ratingLabel.text = "\(rateValue).5"
        } else {
            ratingLabel.text = "\(rateValue).0"
            
            if rateValue != 5 {
                starImages[rateValue].image = UIImage(systemName: "star")
            }
        }
    }

    private func fillStar(upto index: Int) {
        for fillIndex in 0..<index {
            starImages[fillIndex].image = UIImage(systemName: "star.fill")
        }
    }

    private func clearStar(upto index: Int) {
        for clearIndex in stride(from: starImages.count - 1, to: index, by: -1) {
            starImages[clearIndex].image = UIImage(systemName: "star")
        }
    }
}

//MARK: Setup View
extension StarRatingView {
    private func setupView() {
        addSubView()
        setupConstraint()
        addSliderTarget()
    }
    
    private func addSubView() {
        starImages.forEach {
            starStackView.addArrangedSubview($0)
        }
        
        entireStackView.addArrangedSubview(starStackView)
        entireStackView.addArrangedSubview(ratingLabel)
        
        self.addSubview(entireStackView)
        self.addSubview(starSlider)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            entireStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            entireStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            entireStackView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            entireStackView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor,
                                                   multiplier: 7/10),
            
            starImages[0].heightAnchor.constraint(equalTo: starImages[0].widthAnchor),
            ratingLabel.widthAnchor.constraint(equalTo: starStackView.widthAnchor,
                                               multiplier: 1/6),
            
            starSlider.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            starSlider.leadingAnchor.constraint(equalTo: entireStackView.leadingAnchor),
            starSlider.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor,
                                              multiplier: 7/12)
        ])
    }
    
    private func addSliderTarget() {
        starSlider.addTarget(self,
                             action: #selector(sliderStar),
                             for: .valueChanged)
    }
}
