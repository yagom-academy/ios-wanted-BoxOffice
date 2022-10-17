//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

class MainViewController: UIViewController {
    var movie : [Model] = []
    var responses: [movieCodable] = []
    
    @IBOutlet weak var tableView: UITableView!
    let today = Date()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd" 
//        let str = dateFormatter.string(from: today)
        let str = "20211016"
        print(str)
        MovieApi.getData(todays: str) {result in
            self.movie.append(Model(rank:result.dailyBoxOfficeList.rank, rankInten: result.dailyBoxOfficeList.rankInten, moviNm: result.dailyBoxOfficeList.movieNm, openDt: result.dailyBoxOfficeList.openDt ))
            
            self.responses.append(result)
           
            self.tableView.reloadData()
        }
    }
}
extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(movie.count)
        return movie.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let Cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {return UITableViewCell()}
        let data = movie[indexPath.row]
        Cell.dataModel(data)
        
        return Cell
        
    }
    
    
}
