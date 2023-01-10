//
//  MovieDetailDTO.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/03.
//

import Foundation

struct MovieDetailResponseDTO: Decodable {
    let movieInfoResult: MovieDetailContainerDTO
}

struct MovieDetailContainerDTO: Decodable {
    let movieInfo: MovieDetailDTO
}

struct MovieDetailDTO: Decodable {
    let movieCode: String
    let title: String
    let englishTitle: String
    let openingDay: String
    let productionYear: String
    let playTime: String
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let audits: [Audit]

    enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case title = "movieNm"
        case englishTitle = "movieNmEn"
        case openingDay = "openDt"
        case productionYear = "prdtYear"
        case playTime = "showTm"
        case genres = "genres"
        case directors = "directors"
        case actors = "actors"
        case audits
    }

    struct Genre: Decodable {
        let genreName: String
        enum CodingKeys: String, CodingKey {
            case genreName = "genreNm"
        }
    }

    struct Director: Decodable {
        let peopleName: String
        enum CodingKeys: String, CodingKey {
            case peopleName = "peopleNm"
        }
    }

    struct Actor: Decodable {
        let peopleName: String
        enum CodingKeys: String, CodingKey {
            case peopleName = "peopleNm"
        }
    }

    struct Audit: Decodable {
        let watchGrade: String
        enum CodingKeys: String, CodingKey {
            case watchGrade = "watchGradeNm"
        }
    }
}

extension MovieDetailDTO {
    func toDomain() -> MovieDetail {
        return MovieDetail(
            movieCode: movieCode,
            title: title,
            englishTitle: englishTitle,
            productionYear: UInt(productionYear) ?? 0,
            playTime: Double(playTime) ?? 0,
            genre: genres.map { $0.genreName }.joined(separator: ", "),
            directorsName: directors.map { $0.peopleName }.joined(separator: ", "),
            actorsName: actors.map { $0.peopleName }.joined(separator: ", "),
            watchGrade: audits.first?.watchGrade ?? "")
    }
}
