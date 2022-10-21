//
//  MovieInformationViewController.swift
//  BoxOffice
//
//  Created by so on 2022/10/18.
//

import UIKit

class MovieInformationViewController: UIViewController {
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var movieNm: UILabel!
    @IBOutlet weak var openDt: UILabel!
    @IBOutlet weak var audiCnt: UILabel!
    @IBOutlet weak var rankInten: UILabel!
    @IBOutlet weak var rankOldAndNew: UILabel!
    @IBOutlet weak var prdtYear: UILabel!
    @IBOutlet weak var directorsNm: UILabel!
    @IBOutlet weak var actorNm: UILabel?
    @IBOutlet weak var showTm: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var watchGradNm: UILabel!
    @IBOutlet weak var openYear: UILabel!
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var sharebutton: UIButton!
    let mainVC = MainViewController()
    var movieModel : MovieModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        revieView()
        dataSeting()
        uiSetting()
    }
    
    func dataSeting() {
        guard let movieModel = self.movieModel else {return}
        movieInfomationApi.getData(myApiKey: mainVC.myApiKey, todays: mainVC.inquiryTime() ,itemPerPage: "\(mainVC.itemPerPageArry)", movieCd: movieModel.movieCD) { result in
            self.movieNm.text = "영화제목: \(movieModel.movieNm)"
            self.rank.text = "영화 순위: \(movieModel.rank)"
            self.rankOldAndNew.text = "신규진입: \(movieModel.rankOldAndNew)"
            self.audiCnt.text = "관객수:\(movieModel.audiCnt)"
            self.openDt.text = "개봉일: \(movieModel.openDt)"
            self.rankInten.text = "전일대비: \(movieModel.rankInten)"
            self.showTm.text = "상영시간:\(result.movieInfoResult.movieInfo.showTm)분"
            self.genres.text = "장르: \(result.movieInfoResult.movieInfo.genres[0].genreNm)"
            self.watchGradNm.text = "관람등급: \(result.movieInfoResult.movieInfo.audits[0].watchGradeNm)"
            self.openYear.text = "개봉연도: \(result.movieInfoResult.movieInfo.openDt)"
            self.prdtYear.text = "제작연도: \(result.movieInfoResult.movieInfo.prdtYear)"
            if result.movieInfoResult.movieInfo.actors.count == 0 {
                self.actorNm?.text = "배우: "
            }else {
                self.actorNm?.text = "배우: \(result.movieInfoResult.movieInfo.actors[0].peopleNm),\(result.movieInfoResult.movieInfo.actors[1].peopleNm)"
            }
            self.directorsNm.text = "감독: \(result.movieInfoResult.movieInfo.directors[0].peopleNm)"
        }
    }
    func uiSetting() {
        reviewButton.tintColor = .white
        reviewButton.backgroundColor = .systemOrange
        reviewButton.layer.cornerRadius = 12
        reviewButton.alpha = 0.9
        sharebutton.tintColor = .white
        sharebutton.backgroundColor = .systemOrange
        sharebutton.layer.cornerRadius = 12
    }
    func revieView() {
        reviewButton.addTarget(self, action: #selector(reviewButtonAtion), for: .touchUpInside)
    }
    @objc func reviewButtonAtion() {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "ReViewViewController") as? ReViewViewController else {return}
        navigationController?.pushViewController(viewController, animated: true)
    }
}
