//
//  FirstPageViewController.swift
//  BoxOffice
//
//  Created by 박호현 on 2022/10/17.
//

import UIKit

class FirstPageViewController: UIViewController {
    
    var office: [DailyBoxOfficeList] = []
    var targetDay = "20200202"

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        callAPI2()
    }
    
    func callAPI2(){
        MovieAPI.callAPI(targetDay: targetDay) { data in
            self.office = data.boxOfficeResult.dailyBoxOfficeList
            self.tableView.reloadData()
        }
        
    }

}

extension FirstPageViewController: UITableViewDelegate {
    
}

extension FirstPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return office.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as? FirstTableViewCell else { return UITableViewCell() }
        
        let movieInfo = office[indexPath.row]
        cell.setModel(model: movieInfo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
}
