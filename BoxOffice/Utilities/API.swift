//
//  API.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/18.
//

import Foundation
//todo: 박스오피스 api + omdb api
//영진위
//발급키: 623a638bdd2e3b363693d35d04bd8468
//관리명: wanted_BoxOffice
//서비스 사용 URL: wanted_BoxOffice

//omdb
//test sample by title: http://www.omdbapi.com/?t=Bourne+identity&y=2002
//OMDb API: http://www.omdbapi.com/?i=tt3896198&apikey=d591d06e
//key: d591d06e

// TODO: date등 기타 쿼리 넣는법 처리...
// TODO: kofic에서 영문 영화타이틀 얻기 위한 api 구조 추가 --> kofic 박스오피스 기본 api --> movieCd 확인 --> movieCd + key로 영화 상세정보api 호출
enum API {
    case kofic(koficBoxOffice)
    case omdb(movieName: String)
    
    enum koficBoxOffice {
        case daily(date: String)
        case weekly_weekEnd(date: String)
    }
    
    var urlComponets: URLComponents? {
        switch self {
        case .kofic(.daily(_)):
            var baseURLSet = baseURLSet
            baseURLSet?.queryItems = [appIDSet] + getMethodQuerySet
            return baseURLSet
        case .kofic(.weekly_weekEnd(_)):
            var baseURLSet = baseURLSet
            baseURLSet?.queryItems = [appIDSet] + getMethodQuerySet
            return baseURLSet
        case .omdb(_):
            var baseURLSet = baseURLSet
            baseURLSet?.queryItems = [appIDSet] + getMethodQuerySet
            return baseURLSet
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .kofic(.daily(_)):
            return HTTPMethod.GET
        case .kofic(.weekly_weekEnd(_)):
            return HTTPMethod.GET
        case .omdb(_):
            return HTTPMethod.GET
        }
    }
    
    private var baseURLSet: URLComponents? {
        switch self {
        case .kofic(.daily(_)):
            return URLComponents(string: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json")
        case .kofic(.weekly_weekEnd(_)):
            return URLComponents(string: " http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json")
        case .omdb(_):
            return URLComponents(string: "http://www.omdbapi.com/")
        }
    }
    
    private var appIDSet: URLQueryItem {
        switch self {
        case .kofic(_):
            return URLQueryItem(name: "key", value: "623a638bdd2e3b363693d35d04bd8468")
        case .omdb(_):
            return URLQueryItem(name: "apikey", value: "d591d06e")
        }
    }
    
    // TODO: 쿼리 잘 넣는 방법 다시 생각좀...
    private var getMethodQuerySet: [URLQueryItem] {
        switch self {
        case .kofic(.daily(let date)):
            let targetDT = [URLQueryItem(name: "targetDt", value: date)] //yyyymmdd
            let itemPerPage = [URLQueryItem(name: "itemPerPage", value: "10")] //default: 10, max: 10
            let wideAreaCd = [URLQueryItem(name: "wideAreaCd", value: kofic_ComCode)]
            return targetDT + itemPerPage + wideAreaCd
        case .kofic(.weekly_weekEnd(let date)):
            let targetDT = [URLQueryItem(name: "targetDt", value: date)] //yyyymmdd
            let weekGb = [URLQueryItem(name: "weekGb", value: "1")] //0주간, 1주말-디폴트, 2주중
            let itemPerPage = [URLQueryItem(name: "itemPerPage", value: "10")] //default: 10, max: 10
            let wideAreaCd = [URLQueryItem(name: "wideAreaCd", value: kofic_ComCode)]
            
            return targetDT + weekGb + itemPerPage + wideAreaCd
        case .omdb(let movieName):
            let t = [URLQueryItem(name: "t", value: movieName)]
            return t
        }
    }
    
    private var kofic_ComCode: String {
        return "0105001" //seoul only
    }
}
