//
//  Section.swift
//  BoxOffice
//
//  Created by sole on 2022/10/18.
//

import UIKit

enum RankingSection: Int, CaseIterable {
    case onboarding
    case ranking
}

enum RankingItem: Hashable {
    case banner(Banner)
    case ranking(Movie)
    
    var type: String {
        switch self {
        case .banner(_): return "onboarding"
        case .ranking(_): return "ranking"
        }
    }
    
    var ranking: Movie? {
        switch self {
        case .ranking(let movie): return movie
        default: return nil
        }
    }
}

enum DetailSection: Int, CaseIterable {
    case main
    case plot
    case detail
    // TODO: - review

    var title: String? {
        switch self {
        case .main: return nil
        case .plot: return "줄거리"
        case .detail: return "상세정보"
        }
    }
}

enum DetailItem: Hashable {
    case main(MainInformation)
    case plot(Plot)
    case detail(DetailInformation)
    // case review(Review)

    var type: String {
        switch self {
        case .main: return "main"
        case .plot: return "plot"
        case .detail: return "detail"
        // case .review(_): return "review"
        }
    }

    var main: MainInformation? {
        switch self {
        case .main(let mainInformation): return mainInformation
        default: return nil
        }
    }

    var plot: Plot? {
        switch self {
        case .plot(let plot): return plot
        default: return nil
        }
    }

    var detail: DetailInformation? {
        switch self {
        case .detail(let detailInformation): return detailInformation
        default: return nil
        }
    }
}

enum IsIncreased {
    case increased
    case decreased
    case same
    
    var string: String {
        switch self {
        case .increased: return "up↑"
        case .decreased: return "down↓"
        case .same: return "-"
        }
    }
}

struct MainInformation: Hashable {
    let id: Int?
    let posterPath: String?
    let backdropPath: String?
    let ranking: Int
    let ratioComparedToYesterday: Int
    let isIncreased: IsIncreased
    let isNewEntered: Bool 
    let koreanName: String
    let englishName: String
    let releasedDate: String
    let dailyAttendance: Int 
    let totalAttendance: Int
}

struct Plot: Hashable {
    let content: String?
    var isOpend: Bool = false
}

struct DetailInformation: Hashable {
    let productionYear: String
    let releasedYear: String
    let runningTime: String
    let genres: [String]
    let directors: [String]
    let actors: [String]
    let watchGrade: String
}

struct Review: Hashable {
    let profileImagePath: String 
    let userNickName: String
    let stars: [String]
    let content: String
}
