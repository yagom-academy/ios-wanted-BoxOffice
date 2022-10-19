//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

class MainViewController: UIViewController {
    var movie : [MovieModel] = []
    var responses: [MovieCodable] = []
    var response : [InfomationCodable] = []
    @IBOutlet weak var tableView: UITableView!
    
    let itemPerPageArry = 10
    let myApiKey = "e1e395c6dd084d40f20882f0d2fb5da6"
    
    func currentDate() {
        let today = Date()
        let yesterday = today.addingTimeInterval(3600 * -24)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let date = dateFormatter.string(from: yesterday)
        print(date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let today = Date()
        let yesterday = today.addingTimeInterval(3600 * -24)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let date = dateFormatter.string(from: yesterday)
        
        MovieApi.getData(myApiKey: myApiKey, todays: date ,itemPerPage: "\(itemPerPageArry)") {result in
            for i in 0..<self.itemPerPageArry {
                self.movie.append(MovieModel(순위: result.boxOfficeResult.dailyBoxOfficeList[i].rank, 신규진입: result.boxOfficeResult.dailyBoxOfficeList[i].rankOldAndNew.rawValue , 영화제목: result.boxOfficeResult.dailyBoxOfficeList[i].movieNm, 오픈날짜: result.boxOfficeResult.dailyBoxOfficeList[i].openDt, 관객수: result.boxOfficeResult.dailyBoxOfficeList[i].audiCnt,순위증감: result.boxOfficeResult.dailyBoxOfficeList[i].rankInten,영화번호: result.boxOfficeResult.dailyBoxOfficeList[i].movieCD))
                self.tableView.reloadData()
            }
        }
    }
}
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "MovieInformationViewController") as? MovieInformationViewController else {return}
        
        let today = Date()
        let yesterday = today.addingTimeInterval(3600 * -24)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let date = dateFormatter.string(from: yesterday)
        
        movieInfomationApi.getData(myApiKey: myApiKey, todays: date ,itemPerPage: "\(itemPerPageArry)", movieCd: movie[indexPath.row].영화번호) { result in
            let data = self.movie[indexPath.row]
            
            viewController.영화명.text = "영화제목: \(data.영화제목)"
            viewController.영화순위.text = "영화 순위: \(data.순위)"
            viewController.랭킹신규진입.text = "신규진입: \(data.신규진입)"
            viewController.관객수.text = "관객수:\(data.관객수)"
            viewController.개봉일.text = "개봉일: \(data.오픈날짜)"
            viewController.전일대비.text = "전일대비: \(data.순위증감)"
            viewController.상영시간.text = "상영시간:\(result.movieInfoResult.movieInfo.showTm)분"
            viewController.장르.text = "장르: \(result.movieInfoResult.movieInfo.genres[self.response.count].genreNm)"
            viewController.관람등급.text = "관람등급: \(result.movieInfoResult.movieInfo.audits[self.response.count].watchGradeNm)"
            viewController.개봉연도.text = "개봉연도: \(result.movieInfoResult.movieInfo.openDt)"
            viewController.제작연도.text = "제작연도: \(result.movieInfoResult.movieInfo.prdtYear)"
            viewController.배우명.text = "배우: \(result.movieInfoResult.movieInfo.actors[self.response.count].peopleNm)"
            viewController.감독명.text = "감독: \(result.movieInfoResult.movieInfo.directors[self.response.count].peopleNm)"
            
                self.response.append(result)
      
            viewController.navigationItem.title = data.영화제목
        }
        navigationController?.pushViewController(viewController, animated: true)
        
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(movie.count)
        return movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let Cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {return UITableViewCell()}
        let data = movie[indexPath.row]
        Cell.dataModel(data)
        return Cell
        
    }
    
    
}
