//
//  SecondViewController.swift
//  BoxOffice
//
//  Created by 박도원 on 2023/01/04.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    static var data: DailyBoxOfficeList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUiLayout()
    }
    
    func getFilmDetailData(completion: @escaping (Result<FilmDetails, Error>) -> Void) {
        if let movieCode = SecondViewController.data?.movieCd {
            let url = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=635cb0b1404820f91c8a45fcdf831615&movieCd=\(movieCode)"
            NetworkManager().getData(url: url, completion: completion)
        }
    }
    
    func setUiLayout() {
        self.getFilmDetailData { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.sync {
                
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
