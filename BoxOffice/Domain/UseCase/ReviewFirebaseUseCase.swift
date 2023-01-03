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
    
    func save(_ reivew: Review,
              completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        let reviewData: [String: Any] = [
            "nickName": reivew.nickName,
            "password": reivew.password,
            "rating": String(reivew.rating),
            "content": reivew.content,
            "hasPhoto": reivew.hasImage
        ]

        firestoreManager.save(reviewData, with: reivew.password, completion: completion)
    }

    func fetch(completion: @escaping (Result<[Review], FirebaseError>) -> Void) {
        firestoreManager.fetch { [weak self] result in
            switch result {
            case .success(let documents):
                let reviews = documents.compactMap {
                    return self?.toReview(from: $0)
                }
                
                completion(.success(reviews))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func delete(_ review: Review,
                completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        firestoreManager.delete(with: review.password, completion: completion)
    }
}

extension ReviewFirebaseUseCase {
    private func toReview(from document: QueryDocumentSnapshot) -> Review? {
        guard let nickName = document["nickName"] as? String,
              let password = document["password"] as? String,
              let rating = document["rating"] as? Double,
              let content = document["content"] as? String else { return nil }
              let ratingValue = document["rating"] as? String,
              let hasPhoto = document["hasPhoto"] as? Bool else { return nil }
        
        return Review(nickName: nickName,
                      password: password,
                      rating: rating,
                      content: content,
                      hasImage: hasPhoto)
    }
}
