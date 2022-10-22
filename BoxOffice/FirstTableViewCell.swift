//
//  FirstTableViewCell.swift
//  BoxOffice
//
//  Created by 박호현 on 2022/10/17.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
    
    @IBOutlet var rankIncreaseImageLabel: UILabel!
    @IBOutlet var boxOfficeRanking: UILabel!
    @IBOutlet var moiveName: UILabel!
    @IBOutlet var releaseDate: UILabel!
    @IBOutlet var audience: UILabel!
    @IBOutlet var rankIncrease: UILabel!
    @IBOutlet var rankEntryOrNot: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setModel(model: DailyBoxOfficeList) {
        boxOfficeRanking.text = "영화 순위: \(model.rank)"
        moiveName.text = model.movieNm
        releaseDate.text = "\(model.openDt) 개봉"
        audience.text = "\(model.audiCnt)명"
        if Int(model.rankInten) == 0 {
            rankIncreaseImageLabel.text = ""
            rankIncrease.text = ""
        } else if Int(model.rankInten) ?? 0 > 0 {
            rankIncreaseImageLabel.text = "↑"
            rankIncreaseImageLabel.textColor = .red
            rankIncrease.text = model.rankInten
        } else {
            rankIncreaseImageLabel.text = "↓"
            rankIncreaseImageLabel.textColor = .blue
            rankIncrease.text = model.rankInten
        }
        rankEntryOrNot.text = model.rankOldAndNew.rawValue
    }

}
