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
    
    
    
    func setModel(model: MovieInfo) {
        rankingLabel.text = model.rank       //랭킹
        movieTitleLabel.text = model.movieNm     // 제목
        audienceLabel.text = model.audiAcc     //관객수
        openingDateLabel.text = model.openDt    //개봉일
        newRankingLabel.text = model.rankOldAndNew    // 신규 진입
        comparedToYesterdayLabel.text = model.rankInten  //전일대비 순위변동
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
