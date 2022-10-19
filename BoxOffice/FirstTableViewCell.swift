//
//  FirstTableViewCell.swift
//  BoxOffice
//
//  Created by 박호현 on 2022/10/17.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
    
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
        boxOfficeRanking.text = model.rank
        moiveName.text = model.movieNm
        releaseDate.text = model.openDt
        audience.text = model.audiCnt
        rankIncrease.text = model.audiInten
        rankEntryOrNot.text = model.rankOldAndNew.rawValue
    }

}
