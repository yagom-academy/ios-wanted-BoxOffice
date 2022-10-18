//
//  kobisAPI.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/18.
//

import Foundation

enum KobisAPI: TargetType {
    case dailyBoxOfficeList(BoxOfficeListRequest)
    case weeklyBoxOfficeList(BoxOfficeListRequest)
    
    var baseURL: String {
        return "https://kobis.or.kr/kobisopenapi/webservice/rest/"
    }
    
    var path: String {
        switch self {
        case .dailyBoxOfficeList:
            return "boxoffice/searchDailyBoxOfficeList.json"
        case .weeklyBoxOfficeList:
            return "boxoffice/searchWeeklyBoxOfficeList.json"
        }
    }
    
    var request: URLRequest? {
        switch self {
        case .dailyBoxOfficeList(let param):
            var components = URLComponents(string: fullPath)
            components?.queryItems = try? param.asURLQuerys()
            guard let url = components?.url else { return nil }
            return URLRequest(url: url)
        case .weeklyBoxOfficeList(let param):
            var components = URLComponents(string: fullPath)
            components?.queryItems = try? param.asURLQuerys()
            guard let url = components?.url else { return nil }
            return URLRequest(url: url)
        }
    }
}

// MARK: Request
struct BoxOfficeListRequest: Codable {
    var key: String
    var targetDt: String
    var weekGb: WeekGubun?
    
    enum WeekGubun: String, Codable {
        case weekly = "0"
        case weekend = "1"
        case weekday = "2"
    }
}

// MARK: Response
struct DailyBoxOfficeListResponse: Codable {
    let boxOfficeResult: DailyOfficeResult
    
    struct DailyOfficeResult: Codable {
        let boxofficeType: String
        let showRange: String
        let dailyBoxOfficeList: [BoxOfficeData]
        
        struct BoxOfficeData: Codable {
            let rank: String
            let rankInten: String
            let rankOldAndNew: String
            let movieCd: String
            let movieNm: String
            let openDt: String
            let audiCnt: String
            let audiInten: String
            let audiChange: String
            let audiAcc: String
        }
    }
}

struct WeeklyBoxOfficeListResponse: Codable {
    let boxOfficeResult: WeeklyOfficeResult
    
    struct WeeklyOfficeResult: Codable {
        let boxofficeType: String
        let showRange: String?
        let weeklyBoxOfficeList: [BoxOfficeData]
        
        struct BoxOfficeData: Codable {
            let rank: String
            let rankInten: String
            let rankOldAndNew: String
            let movieCd: String
            let movieNm: String
            let openDt: String
            let audiCnt: String
            let audiInten: String
            let audiChange: String
            let audiAcc: String
        }
    }
}
