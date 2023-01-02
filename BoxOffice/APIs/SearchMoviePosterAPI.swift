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
    
    init(movieTitle: String) {
        self.configuration = APIConfiguration(
            baseUrl: .omdb,
            param: ["apikey": Bundle.main.omdbApiKey,
                    "s": movieTitle]
        )
    }
}

struct MoviePosterResponseDTO: Decodable {
    let Search: [Movie]
    let totalResults: String
    let Response: String
    
    func posterURLString() -> String {
        return Search[0].Poster
    }
}

struct Movie: Decodable {
    let Title: String
    let Year: String
    let imdbID: String
    let `Type`: String
    let Poster: String
}
