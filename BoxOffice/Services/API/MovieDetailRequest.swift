//
//  MovieDetailRequest.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/19.
//

import Foundation

enum MovieDetailRequest {

    case value(forIdentifier: String)

}

extension MovieDetailRequest: RequestType {

    typealias ResponseDataType = MovieDetailResponse

    var baseURL: String { "http://www.kobis.or.kr" }
    var path: String { "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json" }
    var method: HTTPMethod { .get }
    var parameters: HTTPParameters? {
        switch self {
        case .value(let identifier):
            return [
                "key": "f5eef3421c602c6cb7ea224104795888",
                "movieCd": identifier
            ]
        }
    }

}
