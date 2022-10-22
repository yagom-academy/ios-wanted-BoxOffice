//
//  WeekViewController.swift
//  BoxOffice
//
//  Created by 1 on 2022/10/18.
//

import UIKit

class WeekViewController: UIViewController {
    
    @IBOutlet weak var weekTableView: UITableView!
    @IBOutlet weak var weekloader: UIActivityIndicatorView!
    let targetDay = "20190201"
    var weekapi: [WeeklyBoxOfficeList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weekloader.alpha = 1.0
        weekTableView.alpha = 0.0
       
        weekTableView.backgroundColor = .clear
        weekTableView.separatorStyle = .none
        weekTableView.showsVerticalScrollIndicator = false
        
        weekModelAPI()
        
        
        UIView.animate(withDuration: 1.0) {
            self.weekTableView
                .alpha = 1.0
            self.weekloader.alpha = 0.0
        }
    }
    
    
    func weekModelAPI() {
        WeekApi.weekApi(targetDay: targetDay) { data in
            self.weekapi = data.boxOfficeResult.weeklyBoxOfficeList
            self.weekTableView.reloadData()
        }
    }
    
    ///두번째화면 API
    func detailapi(targetData: String, completion: @escaping (MovieInfo) -> Void) {
        MovieApi.callApiDetail(targetData: targetData) { data in
            completion(data.movieInfoResult.movieInfo)
        }
    }
}


extension WeekViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekapi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? WeekTableViewCell else { return UITableViewCell() }
        
        
        let movie = weekapi[indexPath.row]
        cell.weekSetModel(model: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let weekViewController = storyboard?.instantiateViewController(withIdentifier: "WeekSecondViewController") as? WeekSecondViewController else { return }
        
        let selectOffice = weekapi[indexPath.row]
        detailapi(targetData: selectOffice.movieCD) { movieInfo in
            let weekViewModel = WeekViewModel.init(rank: selectOffice.rank, movieTitle: selectOffice.movieNm, openingDate: selectOffice.openDt, genre: movieInfo.genres.first?.genreNm ?? "", runTime: movieInfo.showTm, viewingLevel: movieInfo.audits.first?.watchGradeNm ?? "", audiAcc: selectOffice.audiAcc, audience: selectOffice.audiAcc, director: movieInfo.directors.first?.peopleNm ?? "", actiorName: movieInfo.actors.first?.peopleNm ?? "", yearOfRelease: movieInfo.openDt, yearOfManufacture: movieInfo.prdtYear, comparedToYesterday: selectOffice.rankInten, newRankingLabel: selectOffice.rankOldAndNew.rawValue)
            weekViewController.setModel(weekViewModel)
            self.navigationController?.pushViewController(weekViewController, animated: true)
        }
    }
}
