//
//  APIComponents.swift
//  BoxOffice
//
//  Created by dhoney96 on 2023/01/02.
//

enum Query {
    case boxOffice(targetDt: String)
    case omdbApi(title: String)
    case movieInfo(code: String)
    
    var dictionary: [String: String] {
        switch self {
        case .boxOffice(targetDt: let date):
            return ["targetDt": date]
        case .omdbApi(title: let title):
            return ["t": title]
        case .movieInfo(code: let code):
            return ["movieCd": code]
        }
    }
}

enum Key {
    case boxOffice(key: String)
    case omdbKey(key: String)
    
    var dictionary: [String: String] {
        switch self {
        case .boxOffice(key: let key):
            return ["key": key]
        case .omdbKey(key: let key):
            return ["apikey": key]
        }
    }
}

enum BaseURL: String {
    case boxOfficeURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    case movieInfo = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
    case omdbFullDataURL = "http://www.omdbapi.com"
}

enum APIKey: String {
    case movieInfo = "163b881c74f65476e77bd131ab3dee65"
    case omdb = "116dd1d6"
}
