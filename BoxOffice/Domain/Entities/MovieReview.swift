//
//  MovieReview.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/02.
//

import UIKit

struct MovieReview: Hashable {
    let id: UUID
    let user: User
    let password: String
    let rating: UInt
    let image: UIImage
}

struct User: Hashable {
    let id: UUID
    let nickname: String
}
