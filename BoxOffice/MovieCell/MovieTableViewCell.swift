//
//  MovieTableViewCell.swift
//  BoxOffice
//
//  Created by so on 2022/10/17.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var openingDateLabel: UILabel!
    @IBOutlet weak var audienceLabel: UILabel!
    @IBOutlet weak var increaseRanking: UILabel!
    @IBOutlet weak var newRankingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func dataModel(_ model: Model) {
        rankingLabel.text = model.rank
        openingDateLabel.text = model.openDt
        newRankingLabel.text = model.rankInten
        movieNameLabel.text = model.moviNm
       
    }
}
    
    
