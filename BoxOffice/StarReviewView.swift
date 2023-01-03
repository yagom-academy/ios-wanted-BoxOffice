//
//  StarReviewView.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/03.
//

import UIKit

final class StarReviewView: UIView {

    private let starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .clear
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    init() {
        super.init(frame: .zero)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(grade: Double, maxGrade: Double, color: UIColor) {
        let starColor = color
        let filledStarCount = Int(maxGrade * grade / maxGrade)
        let shouldAddHalfStar = (maxGrade * grade / maxGrade) - Double(filledStarCount) > 0

        for _ in 0..<filledStarCount {
            let starView = UIImageView(image: UIImage(systemName: "star.fill"))
            starView.tintColor = starColor
            starStackView.addArrangedSubview(starView)
        }

        if shouldAddHalfStar {
            let starView = UIImageView(image: UIImage(systemName: "star.leadinghalf.filled"))
            starView.tintColor = starColor
            starStackView.addArrangedSubview(starView)
        }
    }

    private func layout() {
        addSubview(starStackView)
        NSLayoutConstraint.activate([
            starStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            starStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            starStackView.topAnchor.constraint(equalTo: topAnchor),
            starStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
