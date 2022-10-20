//
//  WekkSecondViewController.swift
//  BoxOffice
//
//  Created by 1 on 2022/10/20.
//

import UIKit

struct WeekViewModel {
    let rank: String
    let movieTitle: String
    let openingDate: String
    let genre: String
    let runTime: String
    let viewingLevel: String
    let audiAcc: String
    let audience: String
    let director: String
    let actiorName: String
    let yearOfRelease: String
    let yearOfManufacture: String
    let comparedToYesterday: String
    let newRankingLabel: String
}

class WeekSecondViewController: UIViewController {
    
    @IBOutlet weak var weekRankingLabel: UILabel!
    @IBOutlet weak var weekMovieTitleLabel: UILabel!
    @IBOutlet weak var weekGenreLabel: UILabel!
    @IBOutlet weak var weekViewingLevelLabel: UILabel!
    @IBOutlet weak var weekOpeningDateLabel: UILabel!
    @IBOutlet weak var weekRunTimeLabel: UILabel!
    @IBOutlet weak var weekAudienceLabel: UILabel!
    @IBOutlet weak var weekDirectorName: UILabel!
    @IBOutlet weak var weekActorName: UILabel!
    @IBOutlet weak var weekYearOfReleaseLabel: UILabel!
    @IBOutlet weak var weekYearOfManufactureLabel: UILabel!
    @IBOutlet weak var weekComparedToYesterdayLabel: UILabel!
    @IBOutlet weak var weekNewRankingLabel: UILabel!   

    private var weekViewModel: WeekViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "영화 상세정보"
        setLabels()
    }
    
    
    
    func setModel(_ weekViewModel: WeekViewModel) {
        self.weekViewModel = weekViewModel
    }
   
    func setLabels() {
        guard let weekViewModel else { return }
        weekRankingLabel.text = "\(weekViewModel.rank)위"
        weekMovieTitleLabel.text = "영화: \(weekViewModel.movieTitle)"
        weekOpeningDateLabel.text = "개봉일: \(weekViewModel.openingDate)"
        weekGenreLabel.text = "개요 - \(weekViewModel.genre)"
        weekRunTimeLabel.text = "상영시간: \(weekViewModel.runTime)분"
        weekViewingLevelLabel.text = weekViewModel.viewingLevel
        weekDirectorName.text = "감독: \(weekViewModel.director)"
        weekActorName.text = "배우: \(weekViewModel.actiorName)"
        weekYearOfReleaseLabel.text = "개봉연도: \(weekViewModel.yearOfRelease)"
        weekYearOfManufactureLabel.text = "제작연도: \(weekViewModel.yearOfManufacture)년"
        weekComparedToYesterdayLabel.text = "순위변동: \(weekViewModel.comparedToYesterday)"
        weekNewRankingLabel.text = "신규 진입- \(weekViewModel.newRankingLabel)"
        weekAudienceLabel.text = "관객수: \(weekViewModel.audiAcc)명"

    }
    

}
