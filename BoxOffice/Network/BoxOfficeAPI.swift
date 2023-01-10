//
//  BoxOfficeAPI.swift
//  BoxOffice
//
//  Created by Ellen J on 2023/01/02.
//

import Foundation

protocol ServerAPI {
    var method: HTTPMethod { get }
    var path: String { get }
    var params: [String: String]? { get }
}

enum BoxOfficeAPI {
    case dailyBoxOffice(
        targetDate: String,
        itemPerPage: String,
        isMultiMovie: String
    )
    case detailBoxOffice(
        movieCode: String
    )
    case posterURL(
        movietitle: String
    )
}

extension BoxOfficeAPI: ServerAPI {
    var method: HTTPMethod {
        switch self {
        case .dailyBoxOffice:
            return .get
        case .detailBoxOffice:
            return .get
        case .posterURL:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .dailyBoxOffice:
            return "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        case .detailBoxOffice:
            return "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
        case .posterURL:
            return "http://www.omdbapi.com/"
        }
    }
    
    var params: [String : String]? {
        switch self {
        case .dailyBoxOffice(
            let targetDate,
            let itemPerPage,
            let isMultiMovie
        ):
            return [
                "key": "d9346d4d74e3d01826d92e2a0ebfaf6e",
                "targetDt": targetDate,
                "itemPerPage": itemPerPage,
                "multiMovieYn": isMultiMovie
            ]
        case .detailBoxOffice(
            let movieCode
        ):
            return [
                "key": "55b408ed2fa0cf90fe16095fc05ab3b3",
                "movieCd": movieCode
            ]
        case .posterURL(
            let movieTitle
        ):
            return [
                "apikey": "5462de1b",
                "t": movieTitle
            ]
        }
    }
}
