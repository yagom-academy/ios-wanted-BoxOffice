//
//  MovieDetailUpperCollectionViewCell.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/02.
//

import UIKit

final class MovieDetailUpperCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "movieDetailUpperCollectionViewCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray
        imageView.alpha = 0.3
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let gradeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let rankingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let rankUpDownLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let newlyRankedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        label.transform = CGAffineTransform(rotationAngle: CGFloat.pi / -6)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(movieDetail: MovieDetail) {
        titleLabel.text = movieDetail.title
        gradeLabel.text = "\(movieDetail.watchGrade)세 이상 관람가"
        rankingLabel.text = "\(movieDetail.rank)위"
        rankUpDownLabel.textColor = movieDetail.rankFluctuation > 0 ? .systemRed : .systemBlue
        rankUpDownLabel.text = movieDetail.rankFluctuation > 0 ?  "▲ \(movieDetail.rankFluctuation)" : "▼ \(-movieDetail.rankFluctuation)"
        newlyRankedLabel.text = movieDetail.isNewlyRanked ? "New" : ""
    }

    private func layout() {
        [imageView, titleLabel, gradeLabel, rankingLabel, rankUpDownLabel, newlyRankedLabel].forEach { contentView.addSubview($0) }
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            rankingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            rankingLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            gradeLabel.bottomAnchor.constraint(equalTo: rankingLabel.topAnchor, constant: -5),
            gradeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            titleLabel.bottomAnchor.constraint(equalTo: gradeLabel.topAnchor, constant: -5),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            rankUpDownLabel.leadingAnchor.constraint(equalTo: rankingLabel.trailingAnchor, constant: 10),
            rankUpDownLabel.centerYAnchor.constraint(equalTo: rankingLabel.centerYAnchor),

            newlyRankedLabel.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -2),
            newlyRankedLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -5)
        ])
    }
}
