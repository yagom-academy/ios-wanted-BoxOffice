//
//  MovieOverview.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/02.
//
import Foundation

struct MovieOverview {
    let movieCode: String
    let dayType: DayType
    let region: Region
    let rank: UInt
    let title: String
    let openingDay: Date
    let audienceNumber: UInt
    let rankFluctuation: Int
    let isNewlyRanked: Bool
}

enum DayType {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    case weekdays
    case weekends
}

enum Region {
    case Seoul
}
