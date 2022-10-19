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
    let targetData = "20124079"
    var office: [MovieInfost] = []
    var detailMovie: [MovieInfo] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        officeapi()
        detailapi()
        
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
    func detailapi() {
        MovieApi.callApiDetail(targetData: targetData) { data in
            self.detailMovie.append(MovieInfo(movieNm: data.movieInfoResult.movieInfo.movieNm, showTm: data.movieInfoResult.movieInfo.showTm, prdtYear: data.movieInfoResult.movieInfo.prdtYear, openDt: data.movieInfoResult.movieInfo.openDt, genres: data.movieInfoResult.movieInfo.genres, directors: data.movieInfoResult.movieInfo.directors, actors: data.movieInfoResult.movieInfo.actors, audits: data.movieInfoResult.movieInfo.audits))
            self.firstTableView.reloadData()
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
        
        let respone = detailMovie[indexPath.row]
        secondViewController.loadLabel()  //2api
        secondViewController.movieInfo = MovieInfo.init(movieNm: respone.movieNm, showTm: respone.showTm, prdtYear: respone.prdtYear, openDt: respone.openDt, genres: respone.genres, directors: respone.directors, actors: respone.actors, audits: respone.audits)
        
        let movie = office[indexPath.row]
        secondViewController.setModel()   //1 api
        secondViewController.movieInFost = MovieInfost.init(rank: movie.rank, rankInten: movie.rankInten, rankOldAndNew: movie.rankOldAndNew, audiAcc: movie.audiAcc, movieNm: movie.movieNm, openDt: movie.openDt)

        
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
}

