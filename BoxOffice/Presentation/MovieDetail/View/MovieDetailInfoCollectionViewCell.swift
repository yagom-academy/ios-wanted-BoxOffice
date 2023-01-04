//
//  MovieDetailInfoCollectionViewCell.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/02.
//

import UIKit

final class MovieDetailInfoCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "movieDetailInfoCollectionViewCell"
    private let openDateLabel = MovieInfoView()
    private let genreLabel = MovieInfoView()
    private let playTimeLabel = MovieInfoView()
    private let directorLabel = MovieInfoView()
    private let actorLabel = MovieInfoView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = ColorAsset.detailBackgroundColor
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(movieDetail: MovieDetail, movieOverview: MovieOverview) {
        openDateLabel.setUpContents(name: "개봉", description: movieOverview.openingDay.toString())
        genreLabel.setUpContents(name: "장르", description: movieDetail.genre)
        playTimeLabel.setUpContents(name: "상영시간", description: "\(Int(movieDetail.playTime))분")
        directorLabel.setUpContents(name: "감독", description: movieDetail.directorsName)
        actorLabel.setUpContents(name: "출연", description: movieDetail.actorsName)
    }

    private func layout() {
        [openDateLabel, genreLabel, playTimeLabel, directorLabel, actorLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
            ])
        }

        NSLayoutConstraint.activate([
            openDateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constraint.inset),
            genreLabel.topAnchor.constraint(equalTo: openDateLabel.bottomAnchor, constant: Constraint.inset),
            playTimeLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: Constraint.inset),
            directorLabel.topAnchor.constraint(equalTo: playTimeLabel.bottomAnchor, constant: Constraint.inset),
            actorLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: Constraint.inset),
            actorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constraint.inset)
        ])
    }
}

fileprivate extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: self)
    }
}

extension MovieDetailInfoCollectionViewCell {
    enum Constraint {
        static let inset: CGFloat = 10
    }
}
