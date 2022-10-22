//
//  MovieRanking.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/17.
//

import Foundation

struct MovieRanking: Decodable, Hashable {

    // MARK: Properties

    /// 영화명
    let name: String
    /// 영화코드
    let identifier: String
    /// 박스오피스 순위
    let ranking: Int
    /// 개봉일
    let openDate: Date
    /// 누적관객수
    let numberOfMoviegoers: Int
    /// 전일대비 순위 증감분
    let changeRanking: Int
    /// 랭킹 신규 진입 여부
    let isNewRanking: Bool

    // MARK: Decodable

    enum CodingKeys: String, CodingKey {
        case ranking = "rank"
        case identifier = "movieCd"
        case name = "movieNm"
        case openDate = "openDt"
        case numberOfMoviegoers = "audiAcc"
        case changeRanking = "rankInten"
        case isNewRanking = "rankOldAndNew"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        identifier = try container.decode(String.self, forKey: .identifier)
        ranking = container.decodeStringAsInt(forKey: .ranking)!
        openDate = container.decodeStringAsDate(forKey: .openDate)!
        numberOfMoviegoers = container.decodeStringAsInt(forKey: .numberOfMoviegoers)!
        changeRanking = container.decodeStringAsInt(forKey: .changeRanking)!
        isNewRanking = container.decodeStringAsBool(forKey: .isNewRanking)!
    }
    
}
