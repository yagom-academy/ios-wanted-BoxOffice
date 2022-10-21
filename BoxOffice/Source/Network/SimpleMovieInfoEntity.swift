//
//  SimpleMovieInfo.swift
//  BoxOffice
//
//  Created by 권준상 on 2022/10/19.
//

import UIKit

struct SimpleMovieInfoEntity: Hashable {
    var identifier = UUID()
    var movieId: String
    var englishName: String
    var rank: Int
    var name: String
    var inset: String
    var audience: String
    var release: String
    var oldAndNew: RankOldAndNew
    
    static func == (lhs: SimpleMovieInfoEntity, rhs: SimpleMovieInfoEntity) -> Bool {
        lhs.identifier == rhs.identifier 
    }
}
