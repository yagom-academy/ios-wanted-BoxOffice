//
//  SearchMoviePosterAPI.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/02.
//

import Foundation

struct SearchMoviePosterAPI: API {
    typealias ResponseType = MoviePosterResponseDTO
    
    var configuration: APIConfiguration
    
    init(movieTitle: String, year: String? = nil) {
        if let year = year {
            self.configuration = APIConfiguration(
                baseUrl: .omdb,
                param: ["apikey": Bundle.main.omdbApiKey,
                        "s": movieTitle,
                        "y": year]
            )
        } else {
            self.configuration = APIConfiguration(
                baseUrl: .omdb,
                param: ["apikey": Bundle.main.omdbApiKey,
                        "s": movieTitle]
            )
        }
    }
}

struct MoviePosterResponseDTO: Decodable {
    let search: [Movie]
    let totalResults: String
    let response: String
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
    
    func posterURLString() -> String? {
        let posterURL = search[0].poster
        if posterURL.count < 10 {
            return nil
        } else {
            return posterURL
        }
    }
}

struct Movie: Decodable {
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
