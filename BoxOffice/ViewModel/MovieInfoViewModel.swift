//
//  DetailViewModel.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/19.
//

import Foundation

class MovieInfoViewModel {
    
    var cellViewModel = [TableViewCellViewModel]()
    var reviewCellViewModel = [TableViewCellViewModel]()
    var movieInfoModel: MovieInfoModel?
    let dailyBoxOffice: DailyBoxOfficeList
    var allScore = 0
    
    init(dailyBoxOffice: DailyBoxOfficeList) {
        self.dailyBoxOffice = dailyBoxOffice
    }
    
    func clearCellViewModel() {
        cellViewModel = [TableViewCellViewModel]()
        reviewCellViewModel = [TableViewCellViewModel]()
    }
    
    func averageScore() -> Int {
        if reviewCellViewModel.count == 0 {
            return 0
        }
        let average = allScore / reviewCellViewModel.count
        return average
    }
    
    func sectionCount() -> Int {
        
        var sectionCount = 0
        
        if cellViewModel.count != 0 {
            sectionCount += 2
        }
        if reviewCellViewModel.count != 0 {
            sectionCount += 1
        }
        return sectionCount
    }
    
    func requestFireBase(completion: @escaping ()->()) {
        self.allScore = 0
        FirebaseStorage.shared.fireBasefetchData(movieName: dailyBoxOffice.movieNm) { review in
            self.reviewCellViewModel.append(ReviewCellViewModel(cellData: review))
            self.allScore += review.score
            completion()
        }
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
    
    func deleteReview(password: String, index: Int, completion: @escaping (Bool) -> () ) {
        guard let model = reviewCellViewModel[index] as? ReviewCellViewModel else { return }
        
        if password == model.cellData.password {
            FirebaseStorage.shared.deleteData(id: model.cellData.id, movieName: dailyBoxOffice.movieNm) {
                completion(true)
            }
        } else {
            completion(false)
        }
        
        
    }
}

