//
//  APIConfiguration.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/02.
//

import Foundation

enum HTTPMethod {
    static let get = "GET"
}

enum BaseURL: String {
    case kobis = "http://www.kobis.or.kr/kobisopenapi/webservice/rest"
    case omdb = "http://www.omdbapi.com"
}

enum URLPath: String {
    case dailyBoxOffice = "/boxoffice/searchDailyBoxOfficeList.json"
    case weeklyBoxOffice = "/boxoffice/searchWeeklyBoxOfficeList.json"
    case movieInfo = "/movie/searchMovieInfo.json"
    case empty = ""
}

struct APIConfiguration {
    private let baseUrl: String
    private let param: String
    private let path: String
    private let httpMethod: String
    
    init(
        baseUrl: BaseURL,
        param: [String : Any],
        path: URLPath = URLPath.empty,
        httpMethod: String = HTTPMethod.get
    ) {
        self.baseUrl = baseUrl.rawValue
        self.param = param.queryString
        self.path = path.rawValue
        self.httpMethod = httpMethod
    }
    
    func makeURLRequest() -> URLRequest? {
        guard let url = URL(string: baseUrl + path + "?" + param) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        return request
    }
}
