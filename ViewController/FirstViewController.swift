//
//  FirstViewController.swift
//  BoxOffice
//
//  Created by 1 on 2022/10/17.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var firstTableView: UITableView!
    let targetDay = "20190201"
    var office: [MovieInfost] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        officeapi()
        
    }
    ///첫번째화면 API
    func officeapi() {
        //코다블 을 불러오는문제     코다블 코딩키 검색  코다블
        OfficeApi.callAPI(targetDay: targetDay) { data in
            self.office = data.boxOfficeResult.dailyBoxOfficeList
            self.firstTableView.reloadData()
        }
    }
    ///두번째화면 API
    func detailapi(targetData: String, completion: @escaping (MovieInfo) -> Void) {
        MovieApi.callApiDetail(targetData: targetData) { data in
            completion(data.movieInfoResult.movieInfo)
        }
    }
}

extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return office.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as? MovieListTableViewCell else { return UITableViewCell() }
        
        let movie = office[indexPath.row]
        cell.setModel(model: movie)
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let secondViewController = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else { return }
        
        let selectOffice = office[indexPath.row]
        detailapi(targetData: selectOffice.movieCd) { movieInfo in
            let secondViewModel = SecondViewModel.init(rank: selectOffice.rank, movieTitle: selectOffice.movieNm, openingDate: selectOffice.openDt, genre: movieInfo.genres.first?.genreNm ?? "", runTime: movieInfo.showTm, viewingLevel: movieInfo.audits.first?.watchGradeNm ?? "", audiAcc: selectOffice.audiAcc, audience: selectOffice.audiAcc, director: movieInfo.directors.first?.peopleNm ?? "", actiorName: movieInfo.actors.first?.peopleNm ?? "", yearOfRelease: movieInfo.openDt, yearOfManufacture: movieInfo.prdtYear, comparedToYesterday: selectOffice.rankInten, newRankingLabel: selectOffice.rankOldAndNew)
            secondViewController.setModel(secondViewModel)
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
    }
    
}

