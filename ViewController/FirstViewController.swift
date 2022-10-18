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
    var detailMovie: [MovieInfo] = []
    
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
        return office.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as? MovieListTableViewCell else { return UITableViewCell() }
        
        let test = office[indexPath.row]
        cell.setModel(model: test)
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let secondViewController = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else { return }
        
//        let respone = detailMovie[indexPath.row]
//        secondViewController.detai
        
        
        
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
}
