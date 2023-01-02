//
//  APIComponents.swift
//  BoxOffice
//
//  Created by dhoney96 on 2023/01/02.
//

enum Query {
    case boxOffice(targetDt: String)
    case omdbApi(title: String)
    
    var dictionary: [String: String] {
        switch self {
        case .boxOffice(targetDt: let date):
            return ["targetDt": date]
        case .omdbApi(title: let title):
            return ["t": title]
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
    case omdbFullDataURL = "http://www.omdbapi.com"
    case omdbImgURL = "http://img.omdbapi.com"
}
