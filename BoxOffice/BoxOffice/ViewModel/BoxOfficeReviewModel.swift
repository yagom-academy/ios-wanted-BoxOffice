//
//  BoxOfficeReviewModel.swift
//  BoxOffice
//
//  Created by brad on 2023/01/06.
//

import Foundation
import SwiftUI

protocol BoxOfficeReviewModelProtocol {
    
    func fetchReviewData(getMoviewName: String)
    func uploadReviewData(getMoviewName: String)
}

final class BoxOfficeReviewModel: ObservableObject, BoxOfficeReviewModelProtocol {
    
    private let fireBaseManager = BoxOfficeFirebaseStorageManager()
    
    @Published var reviewList: [Review] = []
    
    @Published var rating = 0
    @Published var nickname = ""
    @Published var password = ""
    @Published var description = ""
    
    @Published var imageArray = [UIImage]()
        
    func fetchReviewData(getMoviewName: String) {
        reviewList = []
        fireBaseManager.fetchReviewList(movieNm: getMoviewName) { (fetchedReviewList: [[String : Any]]) in
            fetchedReviewList.forEach { (reviewData: [String : Any]) in
                guard let nickname = reviewData["nickname"] as? String,
                      let password = reviewData["password"] as? String,
                      let description = reviewData["description"] as? String,
                      let starRank = reviewData["starRank"] as? Int else
                {
                    return
                }
                
                let review = Review(
                    nickname: nickname,
                    password: password,
                    description: description,
                    starRank: starRank
                )
                DispatchQueue.main.async { [weak self] in 
                    self?.reviewList.append(review)
                }
            }
        }
    }
    
    func uploadReviewData(getMoviewName: String) {
        let currentReview = Review(
            nickname: self.nickname,
            password: self.password,
            description: self.description,
            starRank: self.rating)
        fireBaseManager.createData(movieNm: getMoviewName, review: currentReview)
    }
}
