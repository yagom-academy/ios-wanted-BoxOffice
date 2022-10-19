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
    var test : [MovieInfo] = []
    
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
            self.detailMovie = data.movieInfoResult.movieInfo
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
        
//        let respone = detailMovie
        secondViewController.loadLabel()
        secondViewController.movieInfo = MovieInfo.init(movieNm: "영제화목", showTm: "1시간", prdtYear: "2000", openDt: "2000", genres: [Genre(genreNm: "장르")], directors: [Director(peopleNm: "2-감독")], actors: [Actor(peopleNm: "2-배우")], audits: [Audit(watchGradeNm: "2-관람")])
        
//        let movie = office[indexPath.row]
        secondViewController.setModel()
        secondViewController.movieInFost = MovieInfost.init(rank: "1-1등", rankInten: "1-몰라", rankOldAndNew: "1-인아웃", audiAcc: "1-1억", movieNm: "1-제목", openDt: "1-담주수요일")

        
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
}
