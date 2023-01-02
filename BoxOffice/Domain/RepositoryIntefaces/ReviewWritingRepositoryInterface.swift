//
//  MovieReviewRepositoryInterface.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/02.
//

import Foundation

protocol ReviewWritingRepositoryInterface {
    func uploadReview(review: MovieReview, completion: @escaping (Result<Void, Error>) -> Void)
}
