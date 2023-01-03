//
//  ReviewFirestoreUseCase.swift
//  BoxOffice
//
//  Created by Judy on 2023/01/03.
//

import UIKit
import FirebaseFirestore

final class ReviewFirestoreUseCase {
    private let firestoreManager = FireStoreManager.shared
    
    func save(_ reivew: Review) {
        var reviewData: [String: Any] = [
            "nickName": reivew.nickName,
            "password": reivew.password,
            "rating": String(reivew.rating),
            "content": reivew.content,
        ]
        
        if let photo = reivew.photo {
            reviewData.updateValue(photo, forKey: "photo")
        }
        
        firestoreManager.save(reviewData, with: reivew.password)
    }

    func fetch(_ id: String) -> [Review]? {
        var reviews: [Review]?
        
        firestoreManager.fetch { queryDocumentSnapshots in
            reviews = queryDocumentSnapshots.compactMap {
                self.toReview(from: $0)
            }
        }
        
        return reviews
    }

    func delete(_ id: String) {
        firestoreManager.delete(with: id)
    }
}

extension ReviewFirestoreUseCase {
    private func toReview(from document: QueryDocumentSnapshot) -> Review? {
        guard let nickName = document["nickName"] as? String,
              let password = document["password"] as? String,
              let rating = document["rating"] as? Double,
              let content = document["content"] as? String else { return nil }
        
        let photo = document["photo"] as? UIImage
        
        return Review(nickName: nickName,
                      password: password,
                      rating: rating,
                      content: content,
                      photo: photo)
    }
}
