//
//  MovieReviewService.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/20.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift
import OSLog

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
        Logger.persistence.debug("Start fetch document: \(identifier)")
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
            Logger.persistence.debug("Success adding document: \(review.movieIdentifier) \(review.username)")
        } catch {
            Logger.persistence.error("Failure adding document: \(error)")
        }
    }

    func deleteReview(_ review: MovieReview) async throws {
        guard let uuidString = review.uuidString else { fatalError() }
        let reference = reviewCollectionReference(for: review.movieIdentifier)
        try await reference.document(uuidString).delete()
    }

    private func reviewCollectionReference(for identifier: String) -> CollectionReference {
        return db.collection(Self.movieCollection)
            .document(identifier)
            .collection(Self.reviewCollection)
    }

}
