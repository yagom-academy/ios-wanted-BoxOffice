//
//  ReviewWritingRepository.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/05.
//

import UIKit

final class ReviewWritingRepository: ReviewWritingRepositoryInterface {

    private let firebaseService = FirebaseService.shared

    func uploadReview(image: UIImage, review: MovieReview, completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseService.uploadReview(image: image, review: review) { result in
            completion(result)
        }
    }
}
