//
//  FirebaseService.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/04.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage

enum FirebaseError: Error {
    case noData
    case internalError
}

final class FirebaseService {

    static let shared = FirebaseService()
    private let database = Firestore.firestore()
    private let storage = Storage.storage()
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

    func uploadReview(review: MovieReview, completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        let data = review.toDTO().reviewData
        guard let id = data["id"] as? String else { return }
        movieReviewReference.document(id).setData(data) { error in
            guard error == nil else {
                completion(.failure(FirebaseError.internalError))
                return
            }
            completion(.success(()))
        }
    }

    func fetchReviewImage(imageURL: String, completion: @escaping (Result<UIImage?, Error>) -> Void) -> Cancellable? {
        let gsReference = storage.reference(forURL: imageURL)
        let task = gsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            guard error == nil else {
                completion(.failure(FirebaseError.internalError))
                return
            }
            guard let data = data else {
                completion(.failure(FirebaseError.noData))
                return
            }

            completion(.success(UIImage(data: data)))
        }

        return task
    }

    func deleteReview(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        movieReviewReference.document(id).delete() { error in
            guard error == nil else {
                completion(.failure(FirebaseError.internalError))
                return
            }
            completion(.success(()))
        }
    }
}
