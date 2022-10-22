//
//  RankInfo.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/17.
//

import UIKit
import Foundation

struct Movie{
    let boxOfficeInfo : BoxOfficeInfo
    let detailInfo : MovieInfo
    let poster : UIImage
    let rating : [Rating]
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
    let movieCd : String //상세정보 검색하기 위해 필요한 영문 제목의 검색용
}







struct MovieInfoResponse : Decodable{
    let movieInfoResult : MovieInfoResult
}

struct MovieInfoResult : Decodable{
    let movieInfo : MovieInfo
}

struct MovieInfo : Decodable{
    let movieNmEn : String
    //상세 페이지에 필요한 정보들
    let movieNm : String
    let openDt : String //개봉일
    let prdtYear : String //제작년도
    let showTm : String //상영시간
    let genres : [Genre] //장르
    let directors : [PeopleNm] //감독
    let actors : [PeopleNm] //배우
    let audits : [WatchGrade] //관람등급
 //   var audiAcc : String?
}

struct Genre : Decodable{
    let genreNm : String
}

struct PeopleNm : Decodable{
    let peopleNm : String
}

struct WatchGrade : Decodable{
    let watchGradeNm : String
}








struct MovieInfoUsingOMDB : Decodable{
    let Poster : String
    let Ratings : [Rating]
}

struct Rating : Decodable{
    let Source : String
    let Value : String
}
