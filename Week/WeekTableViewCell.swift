//
//  WeekTableViewCell.swift
//  BoxOffice
//
//  Created by 1 on 2022/10/18.
//

import UIKit

class WeekTableViewCell: UITableViewCell {

    
    @IBOutlet weak var weekRankLabel: UILabel!
    @IBOutlet weak var weekMovieTitleLabel: UILabel!
    @IBOutlet weak var weekAudienceLabel: UILabel!
    @IBOutlet weak var weekOpeningDateLabel: UILabel!
    @IBOutlet weak var weekNewrankingLabel: UILabel!
    @IBOutlet weak var weekComparedToYesterdayLabel: UILabel!
    @IBOutlet weak var weekCountLabel: UILabel!
    
    func weekSetModel(model: WeeklyBoxOfficeList) {
        weekRankLabel.text = model.rank
        weekMovieTitleLabel.text = "영화: \(model.movieNm)"
        weekAudienceLabel.text =  "관객수: \(model.audiAcc)명"
        weekOpeningDateLabel.text = "개봉일: \(model.openDt)"
        weekNewrankingLabel.text = "신규 판별 - \(model.rankOldAndNew)"
        weekComparedToYesterdayLabel.text = "순위변동 : \(model.rankInten)"
        
        if model.rankInten == "0" {
            weekComparedToYesterdayLabel.text = "변동없음"
            weekCountLabel.text = " "
        } else if model.rankInten >= "0" {
            weekCountLabel.text = "▲"
            weekCountLabel.textColor = .red
            weekComparedToYesterdayLabel.text = model.rankInten
        } else {
            weekCountLabel.text = "▼"
            weekCountLabel.textColor = .blue
            weekComparedToYesterdayLabel.text = model.rankInten
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        weekRankLabel.textColor = .black
        weekMovieTitleLabel.textColor = weekRankLabel.textColor
        weekAudienceLabel.textColor = weekRankLabel.textColor
        weekOpeningDateLabel.textColor = weekRankLabel.textColor
        weekNewrankingLabel.textColor = weekRankLabel.textColor
        weekComparedToYesterdayLabel.textColor = weekRankLabel.textColor
//
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
