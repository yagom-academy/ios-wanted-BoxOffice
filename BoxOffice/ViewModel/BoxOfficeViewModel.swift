//
//  BoxOfficeViewModel.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/18.
//

import Foundation

class BoxOfficeViewModel {
    
    var cellViewModel = [Int : TableViewCellViewModel]()
    var dd: [Int:Int] = [0:0]
    var BoxOfficeModel: BoxOfficeModel?
    
    func requestBoxOfficeAPI(completion: @escaping ()->()) {
        let today = Date().todayToString()
        let url = "\(EndPoint.kdbDailyURL)?key=\(APIKey.KDB_KEY_ID)&targetDt=\(today)"
        APIService.shared.fetchData(url: url) { (response: BoxOfficeModel?, error) in
            guard let response = response else { return }
            self.BoxOfficeModel = response
            completion()
        }
    }
    
    func requestPosterAPI(model: DailyBoxOfficeList, completion: @escaping (String)->()) {
        let url = "\(EndPoint.naverURL)?query=\(model.movieNm)"
        APIService.shared.fetchImage(url: url) { (response: PosterModel?, error) in
            guard let response = response
            else {
                return
            }
            completion(response.items.first?.image ?? "")
        }
    }
    
    func fetchAPIData(completion: @escaping ()->()) {
        requestBoxOfficeAPI {
            
            guard let boxOfficeModel = self.BoxOfficeModel else { return }
            
            for (index, model) in boxOfficeModel.boxOfficeResult.dailyBoxOfficeList.enumerated() {
                
                self.requestPosterAPI(model: model) { url in
                    let imageURL = url.replacingOccurrences(of: "mit110", with: "mit500")
                    self.cellViewModel[index] = BoxOfficeCellViewModel(cellData: model, posterURL: imageURL)
                    completion()
                }
            }
        }
    }
}
