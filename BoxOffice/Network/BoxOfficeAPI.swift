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
        key: String,
        targetDate: String,
        itemPerPage: String,
        isMultiMovie: String
    )
}

extension BoxOfficeAPI: ServerAPI {
    var method: HTTPMethod {
        switch self {
        case .dailyBoxOffice:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .dailyBoxOffice:
            return "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        }
    }
    
    var params: [String : String]? {
        switch self {
        case .dailyBoxOffice(
            let key,
            let targetDate,
            let itemPerPage,
            let isMultiMovie
        ):
            return [
                "key": key,
                "targetDt": targetDate,
                "itemPerPage": itemPerPage,
                "multiMovieYn": isMultiMovie
            ]
        }
    }
}
