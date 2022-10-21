//
//  Review.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/21.
//

import Foundation

struct Review: Codable {
    var nickname: String
    var photo: Data?
    var rating: Int
    var password: String
    var content: String
}
