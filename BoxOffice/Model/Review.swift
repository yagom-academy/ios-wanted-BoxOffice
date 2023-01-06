//
//  Review.swift
//  BoxOffice
//
//  Created by 천승희 on 2023/01/06.
//

import Foundation

struct Review: Decodable {
    let nickname: String
    let password: String
    let starRating: Double
    let content: String
    let imageURL: String
    let id: String
}
