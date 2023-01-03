//
//  DailyBoxOffice.swift
//  BoxOffice
//
//  Created by dhoney96 on 2023/01/02.
//

import Foundation
//TODO: 파일 분리 및 폴더 정리 필요
//MARK: 일일 박스오피스 DTO
struct BoxOfficeResult: Decodable {
    let boxOfficeResult: DailyBoxOffice
}

struct DailyBoxOffice: Decodable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [BoxOfficeInfo]
}

struct BoxOfficeInfo: Decodable {
    let rank: String // 순위
    let rankInten: String // 순위 증감분
    let rankOldAndNew: String // 순위 진입 여부
    let movieNm: String // 영화 이름
    let openDt: String // 개봉일
    let audiAcc: String // 누적 관객
    let movieCd: String // 영화 코드
}
