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
        case dailyRankingList = "dailyBoxOfficeList"
        case weeklyRankingList = "weeklyBoxOfficeList"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .nestedContainer)
        rankingList = try nestedContainer.decodeIfPresent([MovieRanking].self, forKey: .dailyRankingList) ??
        nestedContainer.decode([MovieRanking].self, forKey: .weeklyRankingList)
    }
    
}
