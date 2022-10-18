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
    @IBOutlet weak var viewingLevelLabel: UILabel!
    @IBOutlet weak var openingDateLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var audienceLabel: UILabel!
    @IBOutlet weak var directorName: UILabel!
    @IBOutlet weak var ActorName: UILabel!
    @IBOutlet weak var YearOfReleaseLabel: UILabel!
    @IBOutlet weak var YearOfManufactureLabel: UILabel!
    @IBOutlet weak var comparedToYesterdayLabel: UILabel!
    @IBOutlet weak var newRankingLabel: UILabel!
    
    var movieInFost: MovieInfost?
    var movieInfo: MovieInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movieInfo = movieInfo {
            rankingLabel.text = movieInfo.movieNm
            movieTitleLabel.text = movieInFost?.movieNm
        }
        
        if let movieInfo = movieInFost {
            rankingLabel.text = movieInfo.movieNm
            movieTitleLabel.text = movieInFost?.movieNm
        }
        
      
    }
}
