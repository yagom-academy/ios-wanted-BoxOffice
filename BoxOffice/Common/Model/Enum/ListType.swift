//
//  ListType.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/18.
//

import Foundation

enum ListType {
    case daily
    case weekly
    case info
    
    var path: String {
        switch self {
        case .daily:
            return "boxoffice/searchDailyBoxOfficeList.json"
        case .weekly:
            return "boxoffice/searchWeeklyBoxOfficeList.json"
        case .info:
            return "movie/searchMovieInfo.json"
        }
    }
}
