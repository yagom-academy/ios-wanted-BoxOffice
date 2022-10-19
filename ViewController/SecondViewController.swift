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
    
    
    
    func setModel() {
        if let movieInfost = movieInFost {
            rankingLabel.text = movieInfost.rank
            movieTitleLabel.text = movieInfost.movieNm
            openingDateLabel.text = movieInfost.openDt
            audienceLabel.text = movieInfost.audiAcc
            comparedToYesterdayLabel.text = movieInfost.rankInten
            newRankingLabel.text = movieInfost.rankOldAndNew
        }
    }
  
    func loadLabel() {
        if let movieInfo = movieInfo {
            genreLabel.text = "\(movieInfo.genres)"
            viewingLevelLabel.text = "\(movieInfo.audits)"
            runTimeLabel.text = movieInfo.showTm
            directorName.text = "\(movieInfo.directors)"
            actorName.text = "\(movieInfo.actors)"
            yearOfReleaseLabel.text = movieInfo.openDt
            yearOfManufactureLabel.text = movieInfo.prdtYear
        }
    }
}
