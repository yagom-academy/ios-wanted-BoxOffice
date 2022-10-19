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
    let dailyBoxOffice: DailyBoxOfficeList
    
    init(dailyBoxOffice: DailyBoxOfficeList) {
        self.dailyBoxOffice = dailyBoxOffice
    }
    
    
    func requestInfoAPI(completion: @escaping ()->()) {
        let url = "\(EndPoint.kdbDetailURL)?key=\(APIKey.KDB_KEY_ID)&movieCd=\(dailyBoxOffice.movieCD)"
        APIService.shared.fetchData(url: url) { (response: MovieInfoModel?, error) in
            guard let response = response else { return }
            self.movieInfoModel = response
            completion()
        }
    }
    
    func fetchAPIData(completion: @escaping ()->()) {
        requestInfoAPI {
            
            guard let model = self.movieInfoModel else { return }
            self.cellViewModel.append(MovieInfoCellViewModel(cellData: model.movieInfoResult.movieInfo, boxOfficeData: self.dailyBoxOffice))
            completion()
            
        }
    }
}

