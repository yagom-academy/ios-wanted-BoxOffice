//
//  MovieInformationViewController.swift
//  BoxOffice
//
//  Created by so on 2022/10/18.
//

import UIKit

class MovieInformationViewController: UIViewController {
    @IBOutlet weak var 영화순위: UILabel!
    @IBOutlet weak var 영화명: UILabel!
    @IBOutlet weak var 개봉일: UILabel!
    @IBOutlet weak var 관객수: UILabel!
    @IBOutlet weak var 전일대비: UILabel!
    @IBOutlet weak var 랭킹신규진입: UILabel!
    @IBOutlet weak var 제작연도: UILabel!
    @IBOutlet weak var 감독명: UILabel!
    @IBOutlet weak var 배우명: UILabel!
    @IBOutlet weak var 상영시간: UILabel!
    @IBOutlet weak var 장르: UILabel!
    @IBOutlet weak var 관람등급: UILabel!
    @IBOutlet weak var 개봉연도: UILabel!
    
    let myApiKey = "e1e395c6dd084d40f20882f0d2fb5da6"
    var movis : MovieModel?
    var info : MovieCodable?
    var subinfo : InfomationCodable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(String(describing: subinfo?.movieInfoResult.movieInfo.movieNm))😈😈😈😈😈😈😈😈😈😈😈😈😈😈😈😈")
        if let info = movis {
            //            print(info.boxOfficeResult.dailyBoxOfficeList.count)
            영화명.text = movis?.영화제목
            print(movis?.영화제목)
            영화순위.text = movis?.순위
        }
//            영화순위.text = info.boxOfficeResult.dailyBoxOfficeList[info.boxOfficeResult.dailyBoxOfficeList.count].rank
        
//            관객수.text = info.movieInfoResult.movieInfo
//            전일대비.text = info.movieInfoResult.movieInfo
//            랭킹신규진입.text =
//            제작연도.text = info.movieInfoResult.movieInfo.prdtYear
//            감독명.text = info.movieInfoResult.movieInfo.prdtStatNm
//            배우명.text = info.movieInfoResult.movieInfo.actors[1].peopleNm
//            상영시간.text = info.movieInfoResult.movieInfo.showTm
//            장르.text = info.movieInfoResult.movieInfo.genres[1].genreNm
//            관람등급.text = info.movieInfoResult.movieInfo.showTm
//            개봉연도.text = info.movieInfoResult.movieInfo.openDt
            

        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
