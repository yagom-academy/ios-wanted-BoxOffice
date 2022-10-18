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
    case movieDetail(MovieDetailRequest)
    
    var baseURL: String {
        return "https://kobis.or.kr/kobisopenapi/webservice/rest/"
    }
    
    var path: String {
        switch self {
        case .dailyBoxOfficeList:
            return "boxoffice/searchDailyBoxOfficeList.json"
        case .weeklyBoxOfficeList:
            return "boxoffice/searchWeeklyBoxOfficeList.json"
        case .movieDetail:
            return "movie/searchMovieInfo.json"
        }
    }
    
    var request: URLRequest? {
        switch self {
        case .dailyBoxOfficeList(let param):
            return request(with: param)
        case .weeklyBoxOfficeList(let param):
            return request(with: param)
        case .movieDetail(let param):
            return request(with: param)
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

struct MovieDetailRequest: Codable {
    var key: String
    var movieCd: String
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

struct MovieDetailResponse: Codable {
    let movieInfoResult: MovieInfoResult
    
    struct MovieInfoResult: Codable {
        let movieInfo: MovieInfo
        
        struct MovieInfo: Codable {
            let movieCd: String
            let movieNm: String
            let movieNmEn: String
            let showTm: String
            let prdtYear: String
            let openDt: String
            let genres: [Genre]
            let directors: [Director]
            let actors: [Actor]
            let audits: [Audit]
            
            struct Genre: Codable {
                let genreNm: String
            }
            
            struct Director: Codable {
                let peopleNm: String
            }
            
            struct Actor: Codable {
                let peopleNm: String
            }
            
            struct Audit: Codable {
                let watchGradeNm: String
            }
        }
    }
}
