//
//  WeekMovieViewController.swift
//  BoxOffice
//
//  Created by so on 2022/10/20.
//

import UIKit

class WeekMovieViewController: UIViewController {
    
    @IBAction func 버튼(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var tableVIew: UITableView!
    let mainVC = MainViewController()
    var weekMovie : [MovieModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "주간 영화"
        movieApi()
    }
    func movieApi() {
        MovieApi.getData(myApiKey: mainVC.myApiKey, todays: mainVC.inquiryTime() ,itemPerPage: "\(mainVC.itemPerPageArry)&weekGb=0") {result in
            for i in 0..<self.mainVC.itemPerPageArry {
                self.weekMovie.append(MovieModel(rank: result.boxOfficeResult.dailyBoxOfficeList[i].rank, rankOldAndNew: result.boxOfficeResult.dailyBoxOfficeList[i].rankOldAndNew.rawValue , movieNm: result.boxOfficeResult.dailyBoxOfficeList[i].movieNm, openDt: result.boxOfficeResult.dailyBoxOfficeList[i].openDt, audiCnt: result.boxOfficeResult.dailyBoxOfficeList[i].audiCnt,rankInten: result.boxOfficeResult.dailyBoxOfficeList[i].rankInten,movieCD: result.boxOfficeResult.dailyBoxOfficeList[i].movieCD))
                self.tableVIew.reloadData()
            }
        }
    }
}
extension WeekMovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekMovie.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeekMovieCellTableViewCell", for: indexPath) as? WeekMovieCellTableViewCell else {return UITableViewCell()}
        let data = weekMovie[indexPath.row]
        cell.movieModel(data)
        return cell
    }
}
extension WeekMovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "MovieInformationViewController") as? MovieInformationViewController else {return}
        viewController.movieModel = weekMovie[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}
