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

class SecondViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var viewingLevelLabel: UILabel!
    @IBOutlet weak var openingDateLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var audienceLabel: UILabel!
    @IBOutlet weak var directorName: UILabel!
    @IBOutlet weak var actorName: UILabel!
    @IBOutlet weak var yearOfReleaseLabel: UILabel!
    @IBOutlet weak var yearOfManufactureLabel: UILabel!
    @IBOutlet weak var comparedToYesterdayLabel: UILabel!
    @IBOutlet weak var newRankingLabel: UILabel!

    @IBOutlet weak var reView: Review!
    private var secondViewModel: SecondViewModel?
    
    @IBOutlet weak var reviewButton: UIButton!
   
    @IBAction func reviewButton(_ sender: Any) {
        guard let thirdViewController = storyboard?.instantiateViewController(withIdentifier: "ThirdViewController") else { return }
        self.navigationController?.pushViewController(thirdViewController, animated: true )
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "영화 상세정보"
        setLabels()
    }
   
    
    func setModel(_ secondViewModel: SecondViewModel) {
        self.secondViewModel = secondViewModel
    }
    
    func setLabels() {
        guard let secondViewModel else { return }
        rankingLabel.text = "\(secondViewModel.rank)위"
        movieTitleLabel.text = "영화: \(secondViewModel.movieTitle)"
        openingDateLabel.text = "개봉일: \(secondViewModel.openingDate)"
        genreLabel.text = "개요 - \(secondViewModel.genre)"
        runTimeLabel.text = "상영시간: \(secondViewModel.runTime)분"
        viewingLevelLabel.text = secondViewModel.viewingLevel 
        directorName.text = "감독: \(secondViewModel.director)"
        actorName.text = "배우: \(secondViewModel.actiorName)"
        yearOfReleaseLabel.text = "개봉연도: \(secondViewModel.yearOfRelease)"
        yearOfManufactureLabel.text = "제작연도: \(secondViewModel.yearOfManufacture)년"
        comparedToYesterdayLabel.text = "순위변동: \(secondViewModel.comparedToYesterday)"
        newRankingLabel.text = "신규 진입- \(secondViewModel.newRankingLabel)"
        audienceLabel.text = "관객수: \(secondViewModel.audiAcc)명"
    }
    
}
