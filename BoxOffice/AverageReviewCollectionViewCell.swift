//
//  AverageReviewCollectionViewCell.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/03.
//

import UIKit

final class AverageReviewCollectionViewCell: UICollectionViewCell {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()

    private let starReview = StarReviewView()

    private let reviewAverageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemYellow
        return label
    }()

    private let reviewWriteButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("관람평 쓰기", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(averageRating: Double, movieTitle: String) {
        titleLabel.text = "'\(movieTitle)' 관람평점"
        starReview.setUpContents(grade: averageRating, maxGrade: 5, color: .systemYellow)
    }

    private func layout() {
        [titleLabel, starReview, reviewWriteButton].forEach {
            contentView.addSubview($0)
        }

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),

            starReview.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            starReview.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),

            reviewAverageLabel.leadingAnchor.constraint(equalTo: starReview.trailingAnchor, constant: 10),
            reviewAverageLabel.centerYAnchor.constraint(equalTo: starReview.centerYAnchor),

            reviewWriteButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            reviewWriteButton.topAnchor.constraint(equalTo: starReview.bottomAnchor, constant: 10)
        ])
    }
}
