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
    var rank: Int
    var openDate: Date
    var audienceCount: Int
    var rankingChange: Int
    var isNewEntryToRank: Bool
    var boxOffice: BoxOffice
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
    init(boxOffice: BoxOffice) {
        self.boxOffice = boxOffice
        self.movieName = boxOffice.movieNm
        self.rank = boxOffice.rank
        self.openDate = boxOffice.openDate
        self.audienceCount = boxOffice.audiAcc
        self.rankingChange = boxOffice.rankInten
        self.isNewEntryToRank = boxOffice.isNewRanked
    }
}
