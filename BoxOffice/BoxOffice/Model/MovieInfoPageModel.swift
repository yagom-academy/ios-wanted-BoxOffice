//
//  MovieInfoModel.swift
//  BoxOffice
//
//  Created by 유한석 on 2023/01/04.
//

import Foundation
/*
 박스오피스 순위
 영화명
 개봉일
 관객수
 전일대비 순위의 증감분
 랭킹에 신규 진입 여부
 제작연도
 개봉연도
 상영시간
 장르
 감독명
 배우명
 관람등급 명칭
 */
struct MovieInfoPageModel {
    let rank: String // DailyMovieBoxOfficeModel
    let movieNm: String
    let openDatDt: String //개봉 일
    let audiCnt: String
    let audiInten: String
    let rankOldAndNew: String
    let prdtYear: String // MovieInfo
    let openYearDt: String
    let showTm: String
    let genreNm: String
    let directors: [Director]
    let actors: [Actor]
    let watchGradeNm: String // Audit의 프로퍼티
    let nations: [Nation]
}
