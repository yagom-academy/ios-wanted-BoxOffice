//
//  MovieDetailDTO.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/03.
//

import Foundation

struct MovieDetailDTO: Decodable {
    let movieCode: String
    let title: String
    let englishTitle: String
    let openingDay: String
    let productionYear: String
    let playTime: String
    let genre: String
    let directorsName: String
    let actorsName: String
    let watchGrade: String

    enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case title = "movieNm"
        case englishTitle = "movieNmEn"
        case openingDay = "openDt"
        case productionYear = "prdtYear"
        case playTime = "showTm"
        case genre = "genreNm"
        case directorsName = "directors"
        case actorsName = "actors"
        case watchGrade = "watchGradeNm"
    }
}

extension MovieDetailDTO {
    func toDomain() -> MovieDetail {
        return MovieDetail(
            movieCode: movieCode,
            rank: 0,
            title: title,
            englishTitle: englishTitle,
            openingDay: openingDay.toDate(),
            audienceNumber: 0,
            rankFluctuation: 0,
            isNewlyRanked: false,
            productionYear: UInt(productionYear) ?? 0,
            playTime: Double(playTime) ?? 0,
            genre: genre,
            directorsName: directorsName,
            actorsName: actorsName,
            watchGrade: UInt(watchGrade) ?? 0,
            posterImageURL: "") // TODO: 여기서 fetch하기
    }
}

fileprivate extension String {
    func toDate() -> Date {
        let formatter = DateFormatter()
        guard let date = formatter.date(from: self) else {
            return Date()
        }

        return date
    }
}
