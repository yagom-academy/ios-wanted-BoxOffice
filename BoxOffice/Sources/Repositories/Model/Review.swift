//
//  Review.swift
//  BoxOffice
//
//  Created by 이예은 on 2023/01/03.
//

import Foundation

struct Review: Codable, FirebaseModel {
    let movieName: String
    let userImage: String
    let stars: Double
    let nickname: String
    let password: String
    let review: String
    let date: Date
}

protocol FirebaseModel {
    
}
