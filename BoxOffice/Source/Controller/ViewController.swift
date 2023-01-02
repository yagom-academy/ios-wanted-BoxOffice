//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .red
        
        let manager = NetworkManager()
        let movieApi = EndPoints.makeDetailMovieApi(key: "163b881c74f65476e77bd131ab3dee65", code: "20227925")
        manager.dataTask(api: movieApi) { result in
            switch result {
            case .success(let data):
                guard let data = data,
                      let jsonData: MovieInfoResult = JSONManager.shared.decodeToArray(from: data) else {
                    return
                }
                print(jsonData)
            case .failure(let error):
                print(error)
            }
        }
    }


}

