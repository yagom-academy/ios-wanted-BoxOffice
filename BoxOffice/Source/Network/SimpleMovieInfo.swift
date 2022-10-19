//
//  SimpleMovieInfo.swift
//  BoxOffice
//
//  Created by 권준상 on 2022/10/19.
//

import Foundation

struct SimpleMovieInfo: Hashable {
    var imageURL: String?
    var englishName: String
    var rank: Int
    var name: String
    var inset: String
    var audience: String
    var release: String
    var oldAndNew: RankOldAndNew
}
