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

    func fetchMovieReviews(of movieCode: String, completion: @escaping (Result<[MovieReviewDTO], Error>) -> Void) {
        movieReviewReference.whereField("movieCode", isEqualTo: movieCode)
            .order(by: "timeStamp", descending: true)
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

    func uploadReview(image: UIImage?, review: MovieReview, completion: @escaping (Result<Void, Error>) -> Void) {
        var data = review.toDTO().reviewData
        data.updateValue(Date(), forKey: "timeStamp")

        guard let id = data["id"] as? String else { return }
        if let image = image {
            uploadImage(id: review.id, image: image) { [weak self] result in
                switch result {
                case .success(let url):
                    data.updateValue(url, forKey: "imageURL")
                    self?.movieReviewReference.document(id).setData(data) { error in
                        guard error == nil else {
                            completion(.failure(FirebaseError.internalError))
                            return
                        }
                        completion(.success(()))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            data.updateValue("", forKey: "imageURL")
            movieReviewReference.document(id).setData(data) { error in
                guard error == nil else {
                    completion(.failure(FirebaseError.internalError))
                    return
                }
                completion(.success(()))
            }
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

extension FirebaseService {
    private func uploadImage(id: UUID, image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        let imageRef = storage.reference().child(id.uuidString)
        guard let imageData = image.jpegData(compressionQuality: 1) else { return }
        let uploadTask = imageRef.putData(imageData, metadata: nil) { metadata, error in
            guard error == nil else {
                completion(.failure(FirebaseError.internalError))
                return
            }

            imageRef.downloadURL { url, error in
                guard error == nil else {
                    completion(.failure(FirebaseError.internalError))
                    return
                }
                guard let url = url else {
                    completion(.failure(FirebaseError.noData))
                    return
                }
                completion(.success(url.absoluteString))
            }
        }
        uploadTask.resume()
    }
}
