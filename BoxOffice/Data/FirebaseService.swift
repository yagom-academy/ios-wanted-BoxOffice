//
//  FirebaseService.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/04.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

enum FirebaseError: Error {
    case noData
    case internalError
}

final class FirebaseService {

    static let shared = FirebaseService()
    private let database = Firestore.firestore()
    private lazy var movieReviewReference = database.collection("movieReview")

    private init() { }

    func fetchMovieReviews(of movieCode: String, completion: @escaping (Result<[MovieReviewDTO], FirebaseError>) -> Void) {
        movieReviewReference.whereField("movieCode", isEqualTo: movieCode)
            .getDocuments { snapShot, error in
                guard error == nil else {
                    completion(.failure(FirebaseError.internalError))
                    return
                }
                guard let snapShot = snapShot else {
                    completion(.failure(FirebaseError.noData))
                    return
                }

                let data = snapShot.documents.compactMap {
                    MovieReviewDTO(reviewData: $0.data())
                }
                completion(.success(data))
            }
    }
}
