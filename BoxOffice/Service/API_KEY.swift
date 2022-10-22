//
//  API_KEY.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/19.
//

import Foundation

struct APIKey {
    //네이버
    static let NAVER_KEY_ID = "i04AFVYaviiNykCc1wY4"
    static let NAVER_KEY_SECRET = "6In1EZspL3"
    //영화진흥원
    static let KDB_KEY_ID = "f5eef3421c602c6cb7ea224104795888"
}

struct EndPoint {
    static let naverURL = "https://openapi.naver.com/v1/search/movie.json"
    static let kdbDailyURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    static let kdbDetailURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
    static let kdbWeeklyURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json"
}

