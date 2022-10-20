//
//  Review.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/18.
//

import Foundation

struct MovieReview: Hashable {

    // MARK: Properties

    private let uuid = UUID()

    let nickname: String
    let password: String
    let rating: Int
    let content: String?
    //    let image: String
}

extension MovieReview {
    static var sampleData: [MovieReview] = [
        MovieReview(nickname: "nickname1", password: "1", rating: 1, content: "review content1"),
        MovieReview(nickname: "nickname2", password: "2", rating: 2, content: "review content2"),
        MovieReview(nickname: "nickname3", password: "3", rating: 3, content: "review content3"),
        MovieReview(nickname: "nickname4", password: "4", rating: 4, content: "review content4"),
        MovieReview(nickname: "nickname5", password: "5", rating: 5, content: "review content5"),
    ]
}
