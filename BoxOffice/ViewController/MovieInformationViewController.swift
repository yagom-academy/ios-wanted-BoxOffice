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
    @IBOutlet weak var 배우명: UILabel?
    @IBOutlet weak var 상영시간: UILabel!
    @IBOutlet weak var 장르: UILabel!
    @IBOutlet weak var 관람등급: UILabel!
    @IBOutlet weak var 개봉연도: UILabel!
    @IBOutlet weak var 리뷰쓰기: UIButton!
    
    let mainVC = MainViewController()
    var movieModel : MovieModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        리뷰창()
        guard let movieModel = self.movieModel else {return}
        movieInfomationApi.getData(myApiKey: mainVC.myApiKey, todays: mainVC.inquiryTime() ,itemPerPage: "\(mainVC.itemPerPageArry)", movieCd: movieModel.영화번호) { result in
            self.영화명.text = "영화제목: \(movieModel.영화제목)"
            self.영화순위.text = "영화 순위: \(movieModel.순위)"
            self.랭킹신규진입.text = "신규진입: \(movieModel.신규진입)"
            self.관객수.text = "관객수:\(movieModel.관객수)"
            self.개봉일.text = "개봉일: \(movieModel.오픈날짜)"
            self.전일대비.text = "전일대비: \(movieModel.순위증감)"
            self.상영시간.text = "상영시간:\(result.movieInfoResult.movieInfo.showTm)분"
            self.장르.text = "장르: \(result.movieInfoResult.movieInfo.genres[0].genreNm)"
            self.관람등급.text = "관람등급: \(result.movieInfoResult.movieInfo.audits[0].watchGradeNm)"
            self.개봉연도.text = "개봉연도: \(result.movieInfoResult.movieInfo.openDt)"
            self.제작연도.text = "제작연도: \(result.movieInfoResult.movieInfo.prdtYear)"
            self.배우명?.text = "배우: \(result.movieInfoResult.movieInfo.actors[0].peopleNm),\(result.movieInfoResult.movieInfo.actors[1].peopleNm)"
            self.감독명.text = "감독: \(result.movieInfoResult.movieInfo.directors[0].peopleNm)"
            print(result)
        }
    }

    func 리뷰창() {
        리뷰쓰기.addTarget(self, action: #selector(클릭), for: .touchUpInside)
        
    }
    @objc func 클릭() {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "ReViewViewController") as? ReViewViewController else {return}
        navigationController?.pushViewController(viewController, animated: true)
        
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
