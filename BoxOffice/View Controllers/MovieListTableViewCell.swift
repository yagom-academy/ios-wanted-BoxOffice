//
//  MovieListTableViewCell.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/17.
//

import UIKit

final class MovieListTableViewCell: UITableViewCell {

    // MARK: UI

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var openDateLabel: UILabel!
    @IBOutlet var numberOfMoviegoersLabel: UILabel!

    // Ranking Info
    @IBOutlet var rankingLabel: UILabel!
    @IBOutlet var isNewRankingLabel: UILabel!
    @IBOutlet var changeRankingInfoView: UIStackView!
    @IBOutlet var changeRankingImageView: UIImageView!
    @IBOutlet var changeRankingLabel: UILabel!

}
