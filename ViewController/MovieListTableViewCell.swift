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
    
    
    
    func setModel(model: MovieInfost) {
        rankingLabel.text = model.rank       //랭킹
        movieTitleLabel.text = "영화: \(model.movieNm)"     // 제목
        audienceLabel.text = "관객수: \(model.audiAcc)명"     //관객수
        openingDateLabel.text = "개봉일: \(model.openDt)"    //개봉일
        newRankingLabel.text = "신규 판별 - \(model.rankOldAndNew)"    // 신규 진입
        comparedToYesterdayLabel.text = "순위변동 : \(model.rankInten)"  //전일대비 순위변동
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
