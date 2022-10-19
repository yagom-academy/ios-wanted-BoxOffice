//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

class MainViewController: UIViewController {
    var movie : [MovieModel] = []
    @IBOutlet weak var tableView: UITableView!
    
    let itemPerPageArry = 10
    let myApiKey = "e1e395c6dd084d40f20882f0d2fb5da6"
    
    func inquiryTime() -> String {
        let today = Date()
        let yesterday = today.addingTimeInterval(3600 * -24)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let date = dateFormatter.string(from: yesterday)
        return date
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        MovieApi.getData(myApiKey: myApiKey, todays: inquiryTime() ,itemPerPage: "\(itemPerPageArry)") {result in
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
        viewController.movieModel = movie[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let Cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {return UITableViewCell()}
        let data = movie[indexPath.row]
        Cell.dataModel(data)
        return Cell
    }
}
