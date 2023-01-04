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
        case imageURL
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
              let imageURL = reviewData[Keys.imageURL.rawValue] as? String,
              let password = reviewData[Keys.password.rawValue] as? String,
              let description = reviewData[Keys.description.rawValue] as? String else {
            return dummyMovieReview
        }

        return MovieReview(id: id, movieCode: movieCode, user: User(nickname: userName), password: password, rating: rating, image: imageURL, description: description)
    }
}

extension MovieReview {
    func toDTO() -> MovieReviewDTO {
        var reviewDictionary = [String: Any]()
        reviewDictionary.updateValue(id.uuidString, forKey: "id")
        reviewDictionary.updateValue(movieCode, forKey: "movieCode")
        reviewDictionary.updateValue(user.nickname, forKey: "userName")
        reviewDictionary.updateValue(password, forKey: "password")
        reviewDictionary.updateValue(rating, forKey: "rating")
        reviewDictionary.updateValue(image, forKey: "imageURL")
        reviewDictionary.updateValue(description, forKey: "description")
        return MovieReviewDTO(reviewData: reviewDictionary)
    }
}
