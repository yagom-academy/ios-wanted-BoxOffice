//
//  BoxOfficeFireBaseManager.swift
//  BoxOffice
//
//  Created by 유한석 on 2023/01/06.
//

import Foundation
import FirebaseFirestore
import FirebaseCore
import FirebaseFirestoreSwift

final class BoxOfficeFirebaseStorageManager {
    let db: Firestore
    
    init() {
        self.db = Firestore.firestore()
    }
    
    func createData(movieNm: String, review: Review) {
        do {
            let reviewId = UUID().uuidString
            try db.collection(movieNm).document(reviewId).setData(from: review)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    }
    
    func fetchReviewList(movieNm: String, completion: @escaping ([[String: Any]])->Void) {
        db.collection(movieNm).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var reviewListData = [[String: Any]]()
                for document in querySnapshot!.documents {
                    reviewListData.append(document.data())
                }
                completion(reviewListData)
            }
        }
    }
}
