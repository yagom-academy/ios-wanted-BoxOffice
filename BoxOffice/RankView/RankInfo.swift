//
//  RankInfo.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/17.
//

import UIKit
import Foundation

struct RankInfo{
    let rank : Int
    let rankDiff : Int
    let title : String
    let releaseDate : String
    let numOfAudience : Int
    let isNew : Bool
}

struct BoxOfficeResponse : Decodable{
    let boxOfficeResult : BoxOfficeResult
}

struct BoxOfficeResult : Decodable{
    let boxofficeType : String
    let showRange : String
    let dailyBoxOfficeList : [BoxOfficeInfo]
}

struct BoxOfficeInfo : Decodable{
    let rank : String
    let rankInten : String //전일대비증감
    let movieNm : String //영화제목(국문)
    let openDt : String //개봉일
    let audiAcc : String //(누적)관객수
    let rankOldAndNew : String //순위신규진입여부 OLD, NEW
    let movieCd : String //포스터검색하기 위해 필요한 영문 제목의 검색용
}

struct MovieInfoResponse : Decodable{
    let movieInfoResult : MovieInfoResult
}

struct MovieInfoResult : Decodable{
    let movieInfo : MovieInfo
}

struct MovieInfo : Decodable{
    let movieNmEn : String
}

struct MoviePoster : Decodable{
    let poster : String
}
