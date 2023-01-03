//
//  BoxOfficeListCellViewModel.swift
//  BoxOffice
//
//  Created by YunYoungseo on 2023/01/02.
//

import Foundation

struct BoxOfficeListCellViewModel {
    let id = UUID()
    var movieName: String
    var lank: Int
    var openDate: Date
    var audienceCount: Int
    var increaseOrDecreaseInRank: Int
    var isNewEntryToRank: Bool
}

extension BoxOfficeListCellViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(movieName)
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id && lhs.movieName == rhs.movieName
    }
}

extension BoxOfficeListCellViewModel {
    init(movieName: String, lank: Int, openDate: String, audienceCount: Int, increaseOrDecreaseInRank: Int, isNewEntryToRank: Bool) {
        let dateFommater = ISO8601DateFormatter()
        dateFommater.timeZone = TimeZone(identifier: "Asia/Seoul")
        dateFommater.formatOptions = .withFullDate
        let dateFromString = dateFommater.date(from: openDate)

        self.movieName = movieName
        self.lank = lank
        self.openDate = dateFromString  ?? Date(timeIntervalSince1970: .nan)
        self.audienceCount = audienceCount
        self.increaseOrDecreaseInRank = increaseOrDecreaseInRank
        self.isNewEntryToRank = isNewEntryToRank
    }
}
