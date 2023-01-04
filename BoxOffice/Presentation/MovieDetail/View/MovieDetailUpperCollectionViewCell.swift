//
//  MovieDetailUpperCollectionViewCell.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/02.
//

import UIKit

final class MovieDetailUpperCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "movieDetailUpperCollectionViewCell"

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let posterImageMaskView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let rankingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let rankUpDownLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let newlyRankedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
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

    func setUpContents(movieDetail: MovieDetail, movieOverview: MovieOverview, posterImage: UIImage?) {
        titleLabel.text = movieDetail.title
        gradeLabel.text = movieDetail.watchGrade
        rankingLabel.text = "\(movieOverview.rank)위"
        rankUpDownLabel.textColor = movieOverview.rankFluctuation > 0 ? .systemRed : .systemBlue
        rankUpDownLabel.text = movieOverview.rankFluctuation > 0 ?  "▲ \(movieOverview.rankFluctuation)" : "▼ \(-movieOverview.rankFluctuation)"
        newlyRankedLabel.text = movieOverview.isNewlyRanked ? "New" : ""
        posterImageView.image = posterImage
    }

    private func layout() {
        [posterImageView, posterImageMaskView, titleLabel, gradeLabel, rankingLabel, rankUpDownLabel, newlyRankedLabel].forEach { contentView.addSubview($0) }
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            posterImageMaskView.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor),
            posterImageMaskView.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor),
            posterImageMaskView.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            posterImageMaskView.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor),

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
