//
//  MovieReview.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/02.
//

import Foundation

struct MovieReview: Hashable {
    let id: UUID
    let movieCode: String
    let user: User
    let password: String
    let rating: Double
    let image: String
    let description: String
}

struct User: Hashable {
    let nickname: String
}
