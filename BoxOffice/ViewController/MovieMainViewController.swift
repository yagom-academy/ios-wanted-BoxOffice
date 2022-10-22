//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

class MovieMainViewController: UIViewController {
    
    @IBOutlet weak var 버튼: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var movie : [MovieModel] = []
    let itemPerPageArry = 10
    let myApiKey = "e1e395c6dd084d40f20882f0d2fb5da6"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieApi()
    }
    func movieApi() {
        MovieApi.getData(myApiKey: myApiKey, todays: inquiryTime() ,itemPerPage: "\(itemPerPageArry)") {result in
            for i in 0..<self.itemPerPageArry {
                self.movie.append(MovieModel(rank: result.boxOfficeResult.dailyBoxOfficeList[i].rank, rankOldAndNew: result.boxOfficeResult.dailyBoxOfficeList[i].rankOldAndNew.rawValue , movieNm: result.boxOfficeResult.dailyBoxOfficeList[i].movieNm, openDt: result.boxOfficeResult.dailyBoxOfficeList[i].openDt, audiCnt: result.boxOfficeResult.dailyBoxOfficeList[i].audiCnt,rankInten: result.boxOfficeResult.dailyBoxOfficeList[i].rankInten,movieCD: result.boxOfficeResult.dailyBoxOfficeList[i].movieCD))
                self.tableView.reloadData()
            }
        }
    }
    func inquiryTime() -> String {
        let today = Date()
        let yesterday = today.addingTimeInterval(3600 * -24)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let date = dateFormatter.string(from: yesterday)
        return date
    }
    @IBAction func 버튼클릭(_ sender: UIButton) {
        guard let WeekMovieViewController = storyboard?.instantiateViewController(withIdentifier: "WeekMovieViewController") as? WeekMovieViewController else {return}
        navigationController?.pushViewController(WeekMovieViewController, animated: true)
    }
}
extension MovieMainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {return UITableViewCell()}
        let data = movie[indexPath.row]
        cell.movieModel(data)
        return cell
    }
}
extension MovieMainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "MovieInformationViewController") as? MovieInformationViewController else {return}
        viewController.movieModel = movie[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}
