//
//  URLPath.swift
//  BoxOffice
//
//  Created by bard on 2023/01/02.
//

enum URLPath {
    case dailyBoxOfficeList
    case weeklyBoxOfficeList
    case movieInfo
    
    var value: String {
        switch self {
        case .dailyBoxOfficeList:
            return "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        case .weeklyBoxOfficeList:
            return "/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json"
        case .movieInfo:
            return "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
        }
    }
}
