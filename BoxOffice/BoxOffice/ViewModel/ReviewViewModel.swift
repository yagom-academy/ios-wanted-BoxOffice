//
//  ReviewViewModel.swift
//  BoxOffice
//
//  Created by 유한석 on 2023/01/06.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseCore
import FirebaseFirestoreSwift

struct Review: Codable {
    let nickname: String
    let password: String
    let description: String
    let starRank: Int
    let images: [Data]
}

final class BoxOfficeFirebaseStorageManager {
    let db: Firestore
    
    init() {
        FirebaseApp.configure()

        self.db = Firestore.firestore()
    }
    /*
     별명
     암호
     별점
     내용
     (선택) 사진
     */
    func createData(review: Review) {
        do {
            try db.collection("BoxOffice").document("Review").setData(from: review)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    }
    
    func fetchReviewList(nickName: String, completion: @escaping (Review)->Void) {
        let reviewReference = db.collection("BoxOffice").document("Review")
        reviewReference.getDocument(as: Review.self) { result in
            switch result {
            case .success(let review):
                // A `City` value was successfully initialized from the DocumentSnapshot.
                print("Review: \(review)")
                completion(review)
            case .failure(let error):
                // A `City` value could not be initialized from the DocumentSnapshot.
                print("Error decoding city: \(error)")
            }
        }
    }
}
