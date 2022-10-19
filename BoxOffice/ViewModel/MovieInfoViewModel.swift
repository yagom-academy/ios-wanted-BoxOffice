//
//  DetailViewModel.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/19.
//

import Foundation

class MovieInfoViewModel {
    
    var cellViewModel = [TableViewCellViewModel]()
    var movieInfoModel: MovieInfoModel?
    let movieCd: String
    
    init(movieCd: String) {
        self.movieCd = movieCd
    }
    
    
    func requestInfoAPI(completion: @escaping ()->()) {
        let url = "\(EndPoint.kdbDetailURL)?key=\(APIKey.KDB_KEY_ID)&movieCd=\(self.movieCd)"
        APIService.shared.fetchData(url: url) { (response: MovieInfoModel?, error) in
            guard let response = response else { return }
            self.movieInfoModel = response
            completion()
        }
    }
    
    func fetchAPIData(completion: @escaping ()->()) {
        requestInfoAPI {
            
            guard let model = self.movieInfoModel else { return }
            self.cellViewModel.append(MovieInfoCellViewModel(cellData: model.movieInfoResult.movieInfo))
            completion()
            
        }
    }
}

