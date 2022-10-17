//
//  MovieResponse.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/17.
//

import Foundation

struct MovieResponse: Decodable {

    // MARK: Properties

    let movies: [Movie]

    // MARK: Decodable

    enum CodingKeys: String, CodingKey {
        case nestedContainer = "boxOfficeResult"
        case movies = "dailyBoxOfficeList"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.movies = try container
            .nestedContainer(keyedBy: CodingKeys.self, forKey: .nestedContainer)
            .decode([Movie].self, forKey: .movies)
    }
    
}
