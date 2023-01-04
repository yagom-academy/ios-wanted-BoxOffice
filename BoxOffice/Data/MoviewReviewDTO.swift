//
//  MoviewReviewDTO.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/04.
//

import UIKit

struct MovieReviewDTO {
    let reviewData: [String: Any]

    enum Keys: String, CaseIterable {
        case id
        case userName
        case movieCode
        case rating
        case imageUrl
        case password
        case description
    }
}

extension MovieReviewDTO {
    func toDomain() -> MovieReview {
        guard let idString = reviewData[Keys.id.rawValue] as? String,
              let id = UUID(uuidString: idString),
              let userName = reviewData[Keys.userName.rawValue] as? String,
              let movieCode = reviewData[Keys.movieCode.rawValue] as? String,
              let ratingString = reviewData[Keys.rating.rawValue] as? String,
              let rating = Double(ratingString),
              let imageUrl = reviewData[Keys.imageUrl.rawValue] as? String,
              let password = reviewData[Keys.password.rawValue] as? String,
              let description = reviewData[Keys.description.rawValue] as? String else {
            return dummyMovieReview
        }

        return MovieReview(id: id, movieCode: movieCode, user: User(nickname: userName), password: password, rating: rating, image: UIImage(), description: description) // TODO: Image Fetch
    }
}

extension MovieReview {
    func toDTO() -> MovieReviewDTO {
        return MovieReviewDTO(reviewData: [:])
    }
}
