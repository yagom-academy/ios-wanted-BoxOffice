//
//  MovieOverviewDTO.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/03.
//

import Foundation

struct MovieOverviewWeeklyContainerDTO: Decodable {
    let movieOverviewWeeklyDTO: MovieOverviewWeeklyDTO
    
    enum CodingKeys: String, CodingKey {
        case movieOverviewWeeklyDTO = "boxOfficeResult"
    }
}

struct MovieOverviewDailyContainerDTO: Decodable {
    let movieOverviewDailyDTO: MovieOverviewDailyDTO
    
    enum CodingKeys: String, CodingKey {
        case movieOverviewDailyDTO = "boxOfficeResult"
    }
}

struct MovieOverviewWeeklyDTO: Decodable {
    let movieOverviewDTOs: [MovieOverviewDTO]
    
    enum CodingKeys: String, CodingKey {
        case movieOverviewDTOs = "weeklyBoxOfficeList"
    }
}

struct MovieOverviewDailyDTO: Decodable {
    let movieOverviewDTOs: [MovieOverviewDTO]
    
    enum CodingKeys: String, CodingKey {
        case movieOverviewDTOs = "dailyBoxOfficeList"
    }
}

struct MovieOverviewDTO: Decodable {
    let movieCode: String
    let rank: String
    let title: String
    let openingDay: String
    let audienceNumber: String
    let rankFluctuation: String
    let isNewlyRanked: String

    enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case rank
        case title = "movieNm"
        case openingDay = "openDt"
        case audienceNumber = "audiAcc"
        case rankFluctuation = "rankInten"
        case isNewlyRanked = "rankOldAndNew"
    }
}

extension MovieOverviewWeeklyDTO {
    func toDomain() -> [MovieOverview] {
        var movieOverviews = [MovieOverview]()
        
        self.movieOverviewDTOs.forEach { movieOverviewDTO in
            movieOverviews.append(movieOverviewDTO.toDomain(dayType: .weekends))
        }
        
        return movieOverviews
    }
}

extension MovieOverviewDailyDTO {
    func toDomain() -> [MovieOverview] {
        var movieOverviews = [MovieOverview]()
        
        self.movieOverviewDTOs.forEach { movieOverviewDTO in
            movieOverviews.append(movieOverviewDTO.toDomain(dayType: .weekdays))
        }
        
        return movieOverviews
    }
}

extension MovieOverviewDTO {
    func toDomain(dayType: DayType) -> MovieOverview {
        return MovieOverview(
            movieCode: movieCode,
            dayType: dayType,
            region: .Seoul,
            rank: UInt(rank) ?? 0,
            title: title,
            openingDay: openingDay.toDate(),
            audienceNumber: UInt(audienceNumber) ?? 0,
            rankFluctuation: Int(rankFluctuation) ?? 0,
            isNewlyRanked: isNewlyRanked == "NEW" ? true : false
        )
    }
}

fileprivate extension String {
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        guard let date = formatter.date(from: self) else {
            return Date()
        }
        
        return date
    }
}

extension MovieOverviewDailyContainerDTO {
    func toDomain() -> [MovieOverview] {
        return movieOverviewDailyDTO.toDomain()
    }
}

extension MovieOverviewWeeklyContainerDTO {
    func toDomain() -> [MovieOverview] {
        return movieOverviewWeeklyDTO.toDomain()
    }
}
