//
//  ReviewModel.swift
//  BoxOffice
//
//  Created by 유한석 on 2023/01/06.
//

import Foundation

struct Review: Codable {
    let nickname: String
    let password: String
    let description: String
    let starRank: Int
}
