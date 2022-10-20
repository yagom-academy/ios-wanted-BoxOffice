//
//  MovieReviewService.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/20.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore

final class MovieReviewService {

    static let movieCollection = "movies"
    static let reviewCollection = "reviews"

    private let storage: Storage
    private let db: Firestore

    init() {
        self.storage = Storage.storage()
        self.db = Firestore.firestore()
    }

    func reviews(for identifier: String) async throws -> [MovieReview] {
        let reference = reviewCollectionReference(for: identifier)
        let documents = try await reference.getDocuments()
        return documents.documents.map { snapshot -> MovieReview in
            return try! snapshot.data(as: MovieReview.self)
        }
    }

    func addReview(_ review: MovieReview) {
        let reference = reviewCollectionReference(for: review.movieIdentifier)
        do {
            _ = try reference.addDocument(from: review)
        } catch {
            print(error.localizedDescription)
        }
    }

    private func reviewCollectionReference(for identifier: String) -> CollectionReference {
        return db.collection(Self.movieCollection)
            .document(identifier)
            .collection(Self.reviewCollection)
    }

}
