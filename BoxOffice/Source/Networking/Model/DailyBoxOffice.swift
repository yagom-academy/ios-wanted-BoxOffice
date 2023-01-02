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

//MARK: 영화 상세 정보 DTO
struct MovieInfoResult: Decodable {
    let movieInfoResult: MovieInfo
}

struct MovieInfo: Decodable {
    let movieInfo: DetailInfo
}

struct DetailInfo: Decodable {
    let movieNmEn: String // 영화 이름(영어)
    let prdtYear: String // 제작 년도
    let openDt: String // 개봉 년도
    let genres: [Genre] // 장르
    let directors: [Director] // 감독
    let actors: [Actor] // 배우
    let audits: [Audit] // 관람등급
}

struct Genre: Decodable {
    let genreNm: String
}

struct Director: Decodable {
    let peopleNm: String
}

struct Actor: Decodable {
    let peopleNm: String
    let cast: String
}

struct Audit: Decodable {
    let watchGradeNm: String
}

//TODO: JSON 처리를 어떻게 할건지 고민
class JSONManager {
    static let shared = JSONManager()
    private let decoder = JSONDecoder()
    
    private init() { }
    
    func decodeToArray<T: Decodable>(from data: Data) -> T? {
        do {
            let returnData = try self.decoder.decode(T.self, from: data)
            return returnData
        } catch {
            print(error)
            return nil
        }
    }
}
