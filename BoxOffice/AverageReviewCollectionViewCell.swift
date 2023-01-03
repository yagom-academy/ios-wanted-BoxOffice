//
//  AverageReviewCollectionViewCell.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/03.
//

import UIKit

final class AverageReviewCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "averageReviewCollectionViewCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    private let starReview = StarReviewView()

    private let reviewAverageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemYellow
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()

    private let reviewWriteButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("관람평 쓰기", for: .normal)
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.titleEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: 8)
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
        reviewAverageLabel.text = "\(round(averageRating * 10) / 10)"
    }

    private func layout() {
        [titleLabel, starReview, reviewAverageLabel, reviewWriteButton].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),

            starReview.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            starReview.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            starReview.heightAnchor.constraint(equalToConstant: 80),
            starReview.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),

            reviewAverageLabel.leadingAnchor.constraint(equalTo: starReview.trailingAnchor, constant: 10),
            reviewAverageLabel.centerYAnchor.constraint(equalTo: starReview.centerYAnchor),

            reviewWriteButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            reviewWriteButton.topAnchor.constraint(equalTo: starReview.bottomAnchor, constant: 5),
            reviewWriteButton.widthAnchor.constraint(equalToConstant: 150),
            reviewWriteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
