//
//  MovieRankingRequest.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/19.
//

import Foundation

enum MovieRankingRequest {

    case value(atDate: Date, forDuration: DurationUnit)

}

extension MovieRankingRequest: RequestType {

    typealias ResponseDataType = MovieRankingResponse

    var baseURL: String { "http://www.kobis.or.kr" }
    var path: String {
        switch self {
        case let .value(_, duration) where duration == .daily :
            return "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        default:
            return "/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json"
        }
    }
    var method: HTTPMethod  { .get }
    var parameters: HTTPParameters? {
        switch self {
        case let .value(date, duration) where duration == .weekend:
            return [
                "key": "09f3b35d45fcb4b7d0d5ba56e49cdaa9",
                "targetDt": date.string(),
                "weekGb": "0",
                "wideAreaCd": "0105001"
            ]
        case let .value(date, _):
            return [
                "key": "09f3b35d45fcb4b7d0d5ba56e49cdaa9",
                "targetDt": date.string(),
                "wideAreaCd": "0105001"
            ]
        }
    }

}
