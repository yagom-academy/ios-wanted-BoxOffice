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
    
    var path: String {
        switch self {
        case .daily:
            return "searchDailyBoxOfficeList.json"
        case .weekly:
            return "searchWeeklyBoxOfficeList.json"
        }
    }
}
