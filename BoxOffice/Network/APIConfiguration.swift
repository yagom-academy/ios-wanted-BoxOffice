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
    case kobis = "https://www.kobis.or.kr/kobisopenapi/webservice/rest"
    case omdb = "https://www.omdbapi.com"
}

enum URLPath: String {
    case dailyBoxOffice = "/boxoffice/searchDailyBoxOfficeList.json"
    case weeklyBoxOffice = "/boxoffice/searchWeeklyBoxOfficeList.json"
    case movieInfo = "/movie/searchMovieInfo.json"
    case empty = ""
}

struct APIConfiguration {
    private let baseUrl: String
    private let paramList: [URLQueryItem]
    private let path: String
    private let httpMethod: String
    
    init(
        baseUrl: BaseURL,
        param: [String : Any],
        path: URLPath = URLPath.empty,
        httpMethod: String = HTTPMethod.get
    ) {
        self.baseUrl = baseUrl.rawValue
        self.paramList = param.queryItems
        self.path = path.rawValue
        self.httpMethod = httpMethod
    }
    
    func makeURLRequest() -> URLRequest? {
        guard var urlComponent = URLComponents(string: baseUrl + path) else { return nil }
        urlComponent.queryItems = paramList
        guard let url = urlComponent.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        return request
    }
}
