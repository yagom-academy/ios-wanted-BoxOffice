//
//  OMDbPosterAPIRequest.swift
//  BoxOffice
//
//  Created by unchain on 2023/01/04.
//

import Foundation

struct OMDbPosterAPIRequest: OMDbAPIRequest {
    typealias APIResponse = PosterResultResponse

    let movieEnglishName: String
    let openDateYear: String

    var path: URLPath?
    var headers: [String : String]?
    var body: Data?
    var queryItems: [String : String]? {
        [
            "apikey": "ba22da94",
            "t": movieEnglishName,
            "y": openDateYear
        ]
    }

    init(movieEnglishName: String, openDateYear: String) {
        self.movieEnglishName = movieEnglishName
        self.openDateYear = openDateYear
    }
}
