//
//  UploadReviewUseCase.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/02.
//

import UIKit

final class UploadReviewUseCase {
    private let repository: ReviewWritingRepositoryInterface

    init(repository: ReviewWritingRepositoryInterface = ReviewWritingRepository()) {
        self.repository = repository
    }

    func execute(image: UIImage?, review: MovieReview, completion: @escaping (Result<Void, Error>) -> Void) {
        repository.uploadReview(image: image, review: review) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
