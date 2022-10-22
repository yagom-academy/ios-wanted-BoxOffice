//
//  MainItem.swift
//  BoxOffice
//
//  Created by sole on 2022/10/21.
//

import UIKit

enum MainItem: Hashable {
    case banner(Banner)
    case ranking(Movie)
    
    var type: String {
        switch self {
        case .banner(_): return "banner"
        case .ranking(_): return "ranking"
        }
    }
    
    var ranking: Movie? {
        switch self {
        case .ranking(let movie): return movie
        default: return nil
        }
    }
    
    var banner: Banner? {
        switch self {
        case .banner(let image): return image
        default: return nil
        }
    }
}

struct Banner: Hashable {
    let image: UIImage
}

struct Movie: Hashable {
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
    let content: String?
    let productionYear: Int
    let runningTime: Int
    let genres: String
    let directors: String
    let actors: String
    let watchGrade: String
}

enum IsIncreased {
    case increased
    case decreased
    case same
    
    var stringType: String {
        switch self {
        case .increased: return "up↑"
        case .decreased: return "down↓"
        case .same: return ""
        }
    }
}

enum IsNewInRank: String, Decodable {
    case new = "NEW"
    case old = "OLD"

    var value: Bool {
        switch self {
        case .new: return true
        case .old: return false
        }
    }
}
