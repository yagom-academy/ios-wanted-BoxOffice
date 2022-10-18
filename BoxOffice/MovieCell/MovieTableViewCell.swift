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
    func dataModel(_ model: MovieModel) {
        rankingLabel.text = "영화순위: \(model.순위)"
        openingDateLabel.text = "개봉 날짜: \(model.오픈날짜)"
        newRankingLabel.text = "신규진입: \(model.신규진입)"
        movieNameLabel.text = "영화명: \(model.영화제목)"
        audienceLabel.text = "관객수: \(model.관객수)"
        increaseRanking.text = "전날대비순위: \(model.순위증감)"
        
    }
}
    
    
