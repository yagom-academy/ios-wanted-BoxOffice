//
//  DetailItem.swift
//  BoxOffice
//
//  Created by sole on 2022/10/21.
//

import Foundation

enum DetailItem: Hashable {
    case mainInfo(MainInfo)
    case plotInfo(PlotInfo)
    case detailInfo(DetailInfo)

    var type: String {
        switch self {
        case .mainInfo: return "mainInfo"
        case .plotInfo: return "plotInfo"
        case .detailInfo: return "detailInfo"
        }
    }

    var main: MainInfo? {
        switch self {
        case .mainInfo(let mainInfo): return mainInfo
        default: return nil
        }
    }

    var plot: PlotInfo? {
        switch self {
        case .plotInfo(let plotInfo): return plotInfo
        default: return nil
        }
    }

    var detail: DetailInfo? {
        switch self {
        case .detailInfo(let detailInfo): return detailInfo
        default: return nil
        }
    }
}

struct MainInfo: Hashable {
    let id: Int?
    let posterPath: String?
    let backdropPath: String?
    let rank: Int
    let ratioComparedToYesterday: Int
    var isIncreased: IsIncreased {
        if ratioComparedToYesterday == 0 {
            return .same
        } else if ratioComparedToYesterday > 0 {
            return .increased
        } else {
            return .decreased
        }
    }
    let isNewInRank: IsNewInRank
    let name: String
    let nameInEnglish: String
    let releasedDate: Date
    let dailyAudience: Int
    let totalAudience: Int
}

struct PlotInfo: Hashable {
    let content: String?
    var isOpend: Bool = false
}

struct DetailInfo: Hashable {
    let productionYear: Int
    let releasedYear: Int
    let runningTime: Int
    let genres: String
    let directors: String
    let actors: String
    let watchGrade: String
}


