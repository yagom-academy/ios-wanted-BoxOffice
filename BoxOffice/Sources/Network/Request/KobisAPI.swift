//
//  KobisAPI.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/03.
//

import Foundation

enum KobisAPI: TargetType {
    
    case dailyBoxOfficeList(BoxOfficeListRequest)
    case weeklyBoxOfficeList(BoxOfficeListRequest)
    case movieInfo(MovieRequest)
    
    var path: String {
        switch self {
        case .dailyBoxOfficeList: return "boxoffice/searchDailyBoxOfficeList.json"
        case .weeklyBoxOfficeList: return "boxoffice/searchWeeklyBoxOfficeList.json"
        case .movieInfo: return "movie/searchMovieInfo.json"
        }
    }
    
    var baseURL: String {
        return "https://www.kobis.or.kr/kobisopenapi/webservice/rest"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    var request: URLRequest? {
        switch self {
        case .dailyBoxOfficeList(let param): return request(with: param)
        case .weeklyBoxOfficeList(let param): return request(with: param)
        case .movieInfo(let param): return request(with: param)
        }
    }
    
    
}

struct BoxOfficeListRequest: Codable {
    
    let key: String
    let targetDt: String
    var wideAreaCd: String = "0105001"
    var weekGb: WeekGubun?
    
    enum WeekGubun: String, Codable {
        case weekly = "0"
        case weekend = "1"
        case weekday = "2"
    }
    
}
    
struct MovieRequest: Codable {
    
    let key: String
    let movieCd: String
    
}
