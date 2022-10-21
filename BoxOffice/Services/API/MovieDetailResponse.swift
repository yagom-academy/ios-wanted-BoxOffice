//
//  MovieDetailResponse.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/20.
//

import Foundation

struct MovieDetailResponse: Decodable {

    // MARK: Properties

    let movieDetail: MovieDetail

    // MARK: Decodable

    enum CodingKeys: String, CodingKey {
        case nestedContainer = "movieInfoResult"
        case movieDetail = "movieInfo"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        movieDetail = try container
            .nestedContainer(keyedBy: CodingKeys.self, forKey: .nestedContainer)
            .decode(MovieDetail.self, forKey: .movieDetail)
    }

}
