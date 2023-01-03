//
//  ReviewFirestoreUseCase.swift
//  BoxOffice
//
//  Created by Judy on 2023/01/03.
//

import UIKit
import FirebaseFirestore

final class ReviewFirebaseUseCase {
    private let firestoreManager = FirestoreManager.shared
    private let storageManager = StorageManager.shared
    
    func save(_ reivew: Review) {
        var reviewData: [String: Any] = [
            "nickName": reivew.nickName,
            "password": reivew.password,
            "rating": String(reivew.rating),
            "content": reivew.content,
        ]
        
        if let photo = reivew.photo {
            storageManager.save(photo, id: reivew.password)
        }
        
        firestoreManager.save(reviewData, with: reivew.password)
    }

    func fetch() -> [Review]? {
        var reviews: [Review]?
        
        firestoreManager.fetch { [weak self] queryDocumentSnapshots in
            reviews = queryDocumentSnapshots.compactMap {
                return self?.toReview(from: $0)
            }
        }

        return reviews
    }

    func delete(_ review: Review) {
        firestoreManager.delete(with: review.password)
        
        if review.photo != nil {
            storageManager.delete(widh: review.password)
        }
    }
}

extension ReviewFirebaseUseCase {
    private func toReview(from document: QueryDocumentSnapshot) -> Review? {
        guard let nickName = document["nickName"] as? String,
              let password = document["password"] as? String,
              let rating = document["rating"] as? Double,
              let content = document["content"] as? String else { return nil }
        
        var photo: UIImage?
        storageManager.fetch(with: password) { image in
            photo = image
        }
        
        return Review(nickName: nickName,
                      password: password,
                      rating: rating,
                      content: content,
                      photo: photo)
    }
}
