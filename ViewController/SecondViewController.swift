//
//  SecondViewController.swift
//  BoxOffice
//
//  Created by 1 on 2022/10/17.
//

import UIKit

struct SecondViewModel {
    let rank: String
    let movieTitle: String
    let openingDate: String
    let genre: String
    let runTime: String
    let audience: String
    let director: String
    let actiorName: String
    let yearOfRelease: String
    let yearOfManufacture: String
    let comparedToYesterday: String
    let newRankingLabel: String
}

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

    private var secondViewModel: SecondViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
    }
    ///1 api
    func setModel(_ secondViewModel: SecondViewModel) {
        self.secondViewModel = secondViewModel
    }
    
    func setLabels() {
        guard let secondViewModel else { return }
        rankingLabel.text = secondViewModel.rank
        movieTitleLabel.text = secondViewModel.movieTitle
        openingDateLabel.text = "개봉일: \(secondViewModel.openingDate)"
        genreLabel.text = secondViewModel.genre
        runTimeLabel.text = secondViewModel.runTime
        viewingLevelLabel.text = secondViewModel.audience
        directorName.text = secondViewModel.director
        actorName.text = secondViewModel.actiorName
        yearOfReleaseLabel.text = secondViewModel.yearOfRelease
        yearOfManufactureLabel.text = secondViewModel.yearOfManufacture
        comparedToYesterdayLabel.text = secondViewModel.comparedToYesterday
        newRankingLabel.text = secondViewModel.newRankingLabel

    }
//  ///2 api
//    func loadLabel() {
//        if let movieInfo = movieInfo {
//            genreLabel.text = "\(movieInfo.genres[0].genreNm)"
//            viewingLevelLabel.text = "\(movieInfo.audits[0].watchGradeNm)"
//            runTimeLabel.text = "\(movieInfo.showTm)분"
//            directorName.text = "감독:\(movieInfo.directors[0].peopleNm)님"
//            actorName.text = "배우:\(movieInfo.actors[0].peopleNm)님"
//            yearOfReleaseLabel.text = movieInfo.openDt
//            yearOfManufactureLabel.text = movieInfo.prdtYear
//        }
//    }
}
