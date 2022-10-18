//
//  BoxOffice.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/18.
//

import Foundation

struct BoxOffice {
    var rank: Int
    var rankInten: Int
    var rankOldAndNew: RankType
    var movieCode: String
    var movieName: String
    var openDate: String
    var audienceCount: Int
    var audienceInten: Int
    var audienceChange: Int
    var audienceAccumulation: Int
    
    enum RankType: String, Codable {
        case OLD
        case NEW
    }
}
