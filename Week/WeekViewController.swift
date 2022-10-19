//
//  WeekViewController.swift
//  BoxOffice
//
//  Created by 1 on 2022/10/18.
//

import UIKit

class WeekViewController: UIViewController {

    @IBOutlet weak var weekTableView: UITableView!
    let targetDay = "20190201"
    var weekapi: [WeeklyBoxOfficeList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weekModelAPI()
    }

    
    func weekModelAPI() {
        WeekApi.weekApi(targetDay: targetDay) { data in
            self.weekapi = data.boxOfficeResult.weeklyBoxOfficeList
            self.weekTableView.reloadData()
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
}
