//
//  MovieDetail.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/18.
//

import Foundation

struct MovieDetail: Decodable {

    // MARK: Properties
    
    /// 영화코드
    let identifier: String
    /// 상영 시간
    let runningTime: Int
    /// 제작 연도
    let productionDate: String
    /// 개봉 연도
    let openDate: Date
    /// 장르
    var genres = [String]()
    /// 감독
    let directors: [Crew]
    /// 배우
    let actors: [Crew]
    /// 관람등급 명칭
    let watchGrade: String
    /// 감독 및 배우
    var crew: [Crew] {
        directors + actors
    }

    // MARK: Decodable

    enum CodingKeys: String, CodingKey {
        case identifier = "movieCd"
        case runningTime = "showTm"
        case productionDate = "prdtYear"
        case openDate = "openDt"
        case directors
        case actors

        case genresContainer = "genres"
        enum GenresContainer: String, CodingKey {
            case genre = "genreNm"
        }

        case watchGradeContainer = "audits"
        enum WatchGradeContainer: String, CodingKey {
            case watchGrade = "watchGradeNm"
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decode(String.self, forKey: .identifier)
        runningTime = container.decodeStringAsInt(forKey: .runningTime)!
        productionDate = try container.decode(String.self, forKey: .productionDate)
        openDate = container.decodeStringAsDate(forKey: .openDate, withFormat: "yyyyMMdd")!
        directors = try container.decode([Crew].self, forKey: .directors)
        actors = try container.decode([Crew].self, forKey: .actors)

        var genresContainer = try container
            .nestedUnkeyedContainer(forKey: .genresContainer)
        if let count = genresContainer.count {
            self.genres.reserveCapacity(count)
        }
        while !genresContainer.isAtEnd {
            self.genres.append(
                try genresContainer
                    .nestedContainer(keyedBy: CodingKeys.GenresContainer.self)
                    .decode(String.self, forKey: .genre)
            )
        }

        var watchGradeContainer = try container.nestedUnkeyedContainer(forKey: .watchGradeContainer)
        watchGrade = try watchGradeContainer
            .nestedContainer(keyedBy: CodingKeys.WatchGradeContainer.self)
            .decode(String.self, forKey: .watchGrade)
    }

}

struct Crew: Decodable, Hashable {

    // MARK: Properties

    /// 이름
    let name: String
    /// 역할
    let role: String

    // MARK: Decodable

    enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
        case role = "cast"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        role = try container.decodeIfPresent(String.self, forKey: .role) ?? "감독"
    }

}
