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
    var office: [MovieInfo] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //코다블 을 불러오는문제     코다블 코딩키 검색  코다블
        OfficeApi.callAPI(targetDay: targetDay) { data in
            self.office = data.boxOfficeResult.dailyBoxOfficeList
            self.firstTableView.reloadData()
        }
    }
}

extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//                return 5
        
        return office.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as? MovieListTableViewCell else { return UITableViewCell() }
        
            let test = office[indexPath.row]
            cell.setModel(model: test)

//        cell.rankingLabel.text = "1"
        return cell
        
    }
    
    
}
