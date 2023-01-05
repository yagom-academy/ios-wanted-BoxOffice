//
//  BoxOfficeURL.swift
//  BoxOffice
//
//  Created by 유한석 on 2023/01/03.
//

enum BoxOfficeHostAPI: String {
    case dailyBoxOffice = "http://www.kobis.or.kr/kobisopenapi/webservice/rest"
}

enum BoxOfficeAPIKey: String {
    case boxOfficeKey = "1f86fdbac6c7e10dc35af4b3cad1c6af"
}

enum HTTPMethod: String {
    case get = "GET"
}

enum MovieRequestPath: String {
    case dailyBoxOffice = "/boxoffice/searchDailyBoxOfficeList.json?"
    case movieDetail = "/movie/searchMovieInfo.json?"
}
