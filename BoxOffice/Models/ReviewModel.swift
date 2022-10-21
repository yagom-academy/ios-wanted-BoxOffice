//
//  ReviewModel.swift
//  BoxOffice
//
//  Created by Subin Kim on 2022/10/22.
//

import Foundation

struct ReviewModel: Codable {
  let movieCode: String
  let nickname: String
  let password: String
  let review: String
  let score: Int
}
