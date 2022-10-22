//
//  FirstPageViewController.swift
//  BoxOffice
//
//  Created by 박호현 on 2022/10/17.
//

import UIKit

class FirstPageViewController: UIViewController {
    
    var model: [DailyBoxOfficeList] = []
    
    var targetDay = ""
    var tagetdata = ""

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        callAPI2()

    }
    
    func callAPI2(){
        MovieAPI.callAPI(targetDay: targetDay) { data in
            self.model = data.boxOfficeResult.dailyBoxOfficeList
            self.tableView.reloadData()
        }
    }
    
    func callAPI3(tagetdata: String, complesion: @escaping(MovieInfo) -> Void){
        DetailAPI.detailAPI(tagetdata: tagetdata) { data in
            complesion(data.movieInfoResult.movieInfo)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}

extension FirstPageViewController: UITableViewDelegate {
}

extension FirstPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as? FirstTableViewCell else { return UITableViewCell() }
        
        let movieInfo = model[indexPath.row]
        cell.setModel(model: movieInfo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "영화목록"
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailViewController = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else { return }
        
        let data = model[indexPath.row]
        DetailAPI.detailAPI(tagetdata: data.movieCD) { taget in
            _ = Model.init(boxOfficeRank2: data.rank, moiveName2: data.movieNm, openingDate2: data.openDt, audience2: data.audiCnt, rankIncrease2: data.rankInten, newEntry2: data.rankOldAndNew.rawValue, yearOfmanufacture2: taget.movieInfoResult.movieInfo.prdtYear, releaseYear2: taget.movieInfoResult.movieInfo.openDt, movieTime2: taget.movieInfoResult.movieInfo.showTm, genre2: taget.movieInfoResult.movieInfo.genres.first?.genreNm ?? ""
                                   , actorName2: taget.movieInfoResult.movieInfo.actors.first?.peopleNm ?? "", directioName2: taget.movieInfoResult.movieInfo.directors.first?.peopleNm ?? "", viewingLevel2: taget.movieInfoResult.movieInfo.audits.first?.watchGradeNm ?? "")
        }
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}
