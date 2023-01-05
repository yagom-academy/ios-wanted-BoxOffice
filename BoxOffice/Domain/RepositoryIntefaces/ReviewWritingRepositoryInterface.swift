//
//  MovieReviewRepositoryInterface.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/02.
//

import UIKit

protocol ReviewWritingRepositoryInterface {
    func uploadReview(image: UIImage, review: MovieReview, completion: @escaping (Result<Void, Error>) -> Void)
}
