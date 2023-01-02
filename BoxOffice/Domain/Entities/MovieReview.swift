//
//  MovieReview.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/02.
//

import UIKit

struct MovieReview {
    let user: User
    let password: String
    let rating: UInt
    let image: UIImage
}

struct User {
    let nickname: String
}
