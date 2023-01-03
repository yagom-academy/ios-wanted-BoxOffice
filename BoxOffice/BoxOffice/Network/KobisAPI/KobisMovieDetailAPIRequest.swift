//
//  KobisMovieDetailAPIRequest.swift
//  BoxOffice
//
//  Created by bard on 2023/01/03.
//

import Foundation

struct KobisMovieDetailAPIRequest: KobisAPIRequest {
    
    typealias APIResponse = MovieDetailResponse
    
    let movieCode: String
    
    var path: URLPath? = .movieInfo
    var headers: [String : String]?
    var body: Data?
    var queryItems: [String : String]? {
        [
            "key": "019dfeab346ca4bdaa25268affad110a",
            "movieCd": movieCode
        ]
    }
    
    init(movieCode: String) {
        self.movieCode = movieCode
    }
}
