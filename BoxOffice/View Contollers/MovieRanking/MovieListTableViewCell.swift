//
//  MovieListTableViewCell.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/17.
//

import UIKit

final class MovieListTableViewCell: UITableViewCell {

    // MARK: Constants

    struct Design {
        static let upColor: UIColor = .systemPink
        static let downColor: UIColor = .systemBlue
        static let upIcon = UIImage(systemName: "arrowtriangle.up.fill")
        static let downIcon = UIImage(systemName: "arrowtriangle.down.fill")
    }

    // MARK: UI

    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var openDateLabel: UILabel!
    @IBOutlet private var numberOfMoviegoersLabel: UILabel!
    @IBOutlet private var rankingLabel: UILabel!
    @IBOutlet private var isNewRankingInfoView: UIStackView!
    @IBOutlet private var isNewRankingLabel: UILabel!
    @IBOutlet private var changeRankingInfoView: UIStackView!
    @IBOutlet private var changeRankingLabel: UILabel!
    @IBOutlet private var changeRankingImageView: UIImageView!

    // MARK: Properties

    func updateView(with movieRanking: MovieRanking) {
        nameLabel.text = movieRanking.name
        openDateLabel.text = "\(movieRanking.openDate.dateString()) 개봉"
        numberOfMoviegoersLabel.text = "누적관객 \(movieRanking.numberOfMoviegoers.string)명"
        rankingLabel.text = movieRanking.ranking.string
        if movieRanking.isNewRanking {
            isNewRankingInfoView.isHidden = false
            isNewRankingLabel.text = "NEW"
        } else {
            isNewRankingInfoView.isHidden = true
        }
        if movieRanking.changeRanking == 0 {
            changeRankingInfoView.isHidden = true
        } else {
            changeRankingInfoView.isHidden = false
            let isRankUp = movieRanking.changeRanking > 0

            changeRankingLabel.text = movieRanking.changeRanking.string
            if isRankUp {
                changeRankingImageView.image = Design.upIcon
                changeRankingLabel.textColor = Design.upColor
                changeRankingImageView.tintColor = Design.upColor
            } else {
                changeRankingImageView.image = Design.downIcon
                changeRankingLabel.textColor = Design.downColor
                changeRankingImageView.tintColor = Design.downColor
            }
        }
    }

}
