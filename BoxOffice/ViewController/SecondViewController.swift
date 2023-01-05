//
//  SecondViewController.swift
//  BoxOffice
//
//  Created by 박도원 on 2023/01/04.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    static var movieCode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(testLabel)
        testLabel.topAnchor.constraint(equalTo: view.topAnchor)
        testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        setUiLayout()
    }
    
    let testLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func getFilmDetailData(completion: @escaping (Result<FilmDetails, Error>) -> Void) {
        if let movieCode = SecondViewController.movieCode {
            let url = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=635cb0b1404820f91c8a45fcdf831615&movieCd=\(movieCode)"
            NetworkManager().getData(url: url, completion: completion)
        }
    }
    
    func setUiLayout() {
        self.getFilmDetailData { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.sync {
                    self.testLabel.text = success.movieInfoResult.movieInfo.openDt
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
