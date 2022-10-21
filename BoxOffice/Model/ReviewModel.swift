//
//  ReviewModel.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/20.
//

import Foundation

struct Review: Codable {
    let nickname: String
    let password: String
    let score: Int
    let text: String
    let imageURL: String
    let id: UUID
}
