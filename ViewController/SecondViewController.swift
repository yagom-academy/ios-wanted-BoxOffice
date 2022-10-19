//
//  SecondViewController.swift
//  BoxOffice
//
//  Created by 1 on 2022/10/17.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var viewingLevelLabel: UILabel! //관람등급
    @IBOutlet weak var openingDateLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var audienceLabel: UILabel!
    @IBOutlet weak var directorName: UILabel!
    @IBOutlet weak var actorName: UILabel!
    @IBOutlet weak var yearOfReleaseLabel: UILabel!  //개봉연도
    @IBOutlet weak var yearOfManufactureLabel: UILabel!  //제작연도
    @IBOutlet weak var comparedToYesterdayLabel: UILabel!  //전일대비
    @IBOutlet weak var newRankingLabel: UILabel!    ///신규랭킹
    
    var movieInFost: MovieInfost?
    var movieInfo: MovieInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setModel()
        loadLabel()
    }
   
    ///1 api
    func setModel() {
        if let movieInfost = movieInFost {
            rankingLabel.text = movieInfost.rank
            movieTitleLabel.text = movieInfost.movieNm
            openingDateLabel.text = "개봉일 :\(movieInfost.openDt)"
            audienceLabel.text = "관객수: \(movieInfost.audiAcc)명"
            comparedToYesterdayLabel.text = "순위변동 : \(movieInfost.rankInten)"
            newRankingLabel.text = "신규 판별 : \(movieInfost.rankOldAndNew)"
        }
    }
  ///2 api
    func loadLabel() {
        if let movieInfo = movieInfo {
            genreLabel.text = "\(movieInfo.genres[0].genreNm)"
            viewingLevelLabel.text = "\(movieInfo.audits[0].watchGradeNm)"
            runTimeLabel.text = movieInfo.showTm
            directorName.text = "감독:\(movieInfo.directors[0].peopleNm)님"
            actorName.text = "배우:\(movieInfo.actors[0].peopleNm)님"
            yearOfReleaseLabel.text = movieInfo.openDt
            yearOfManufactureLabel.text = movieInfo.prdtYear
        }
    }
}
