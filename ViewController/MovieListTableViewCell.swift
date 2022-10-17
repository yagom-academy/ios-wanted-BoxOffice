//
//  MovieListTableViewCell.swift
//  BoxOffice
//
//  Created by 1 on 2022/10/17.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var audienceLabel: UILabel!  // 관객
    @IBOutlet weak var openingDateLabel: UILabel!
    @IBOutlet weak var newRankingLabel: UILabel!
    @IBOutlet weak var comparedToYesterdayLabel: UILabel!
    
    
    
    func setModel(model: Movie) {
        rankingLabel.text = "\(model.ranking)"
        movieTitleLabel.text = model.movieTitle
        audienceLabel.text = "\(model.audience)"
        openingDateLabel.text = "\(model.openingDate)"
        newRankingLabel.text = "\(model.newRanking)"
        comparedToYesterdayLabel.text = "\(model.comparedToYesterday)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
