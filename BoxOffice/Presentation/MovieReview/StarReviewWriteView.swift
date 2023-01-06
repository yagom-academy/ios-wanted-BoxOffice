//
//  StarReviewWriteView.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/06.
//

import UIKit

final class StarReviewWriteView: UIView {

    var rating: Double = 0

    private lazy var starButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        starButtons.forEach { stackView.addArrangedSubview($0) }
        stackView.axis = .horizontal
        stackView.backgroundColor = .clear
        return stackView
    }()

    private let starButton1 = UIButton()
    private let starButton2 = UIButton()
    private let starButton3 = UIButton()
    private let starButton4 = UIButton()
    private let starButton5 = UIButton()
    private lazy var starButtons = [starButton1, starButton2, starButton3, starButton4, starButton5]

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        setupStarButtons()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func layout() {
        addSubview(starButtonsStackView)
        NSLayoutConstraint.activate([
            starButtonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            starButtonsStackView.topAnchor.constraint(equalTo: topAnchor),
            starButtonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            starButtonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    private func setupStarButtons() {
        let sizeConfiguration = UIImage.SymbolConfiguration(pointSize: 35)

        starButtons.forEach { star in
            star.setImage(UIImage(systemName: "star", withConfiguration: sizeConfiguration), for: .normal)
            star.setImage(UIImage(systemName: "star.fill", withConfiguration: sizeConfiguration), for: .selected)
            star.tintColor = .systemYellow
        }

        configureStarButtonsAction()
    }

    private func configureStarButtonsAction() {
        starButton1.addAction(UIAction(handler: { action in
            self.starButton1.isSelected = true
            self.starButton2.isSelected = false
            self.starButton3.isSelected = false
            self.starButton4.isSelected = false
            self.starButton5.isSelected = false
            self.rating = 1
        }), for: .touchUpInside)

        starButton2.addAction(UIAction(handler: { action in
            self.starButton1.isSelected = true
            self.starButton2.isSelected = true
            self.starButton3.isSelected = false
            self.starButton4.isSelected = false
            self.starButton5.isSelected = false
            self.rating = 2
        }), for: .touchUpInside)

        starButton3.addAction(UIAction(handler: { action in
            self.starButton1.isSelected = true
            self.starButton2.isSelected = true
            self.starButton3.isSelected = true
            self.starButton4.isSelected = false
            self.starButton5.isSelected = false
            self.rating = 3
        }), for: .touchUpInside)

        starButton4.addAction(UIAction(handler: { action in
            self.starButton1.isSelected = true
            self.starButton2.isSelected = true
            self.starButton3.isSelected = true
            self.starButton4.isSelected = true
            self.starButton5.isSelected = false
            self.rating = 4
        }), for: .touchUpInside)

        starButton5.addAction(UIAction(handler: { action in
            self.starButton1.isSelected = true
            self.starButton2.isSelected = true
            self.starButton3.isSelected = true
            self.starButton4.isSelected = true
            self.starButton5.isSelected = true
            self.rating = 5
        }), for: .touchUpInside)
    }
}
