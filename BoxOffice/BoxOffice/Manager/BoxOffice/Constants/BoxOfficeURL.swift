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
    case boxOfficeKey = "d43c612ada006712230e28a87d48913b"
}

enum HTTPMethod: String {
    case get = "GET"
}

enum MovieRequestPath: String {
    case dailyBoxOffice = "/boxoffice/searchDailyBoxOfficeList.json?"
    case movieDetail = "/movie/searchMovieInfo.json?"
}
