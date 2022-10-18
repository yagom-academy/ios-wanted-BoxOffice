//
//  MovieRankingResponse.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/17.
//

import Foundation

struct MovieRankingResponse: Decodable {

    // MARK: Properties

    let rankingList: [MovieRanking]

    // MARK: Decodable

    enum CodingKeys: String, CodingKey {
        case nestedContainer = "boxOfficeResult"
        case rankingList = "dailyBoxOfficeList"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        rankingList = try container
            .nestedContainer(keyedBy: CodingKeys.self, forKey: .nestedContainer)
            .decode([MovieRanking].self, forKey: .rankingList)
    }
    
}
