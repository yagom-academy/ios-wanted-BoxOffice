//
//  Date+Extension.swift
//  BoxOffice
//
//  Created by bard on 2023/01/03.
//

import Foundation

extension Date {
    var now: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "yyyyMMdd"
        let formattedDate = formatter.string(from: self)
        
        return formattedDate
    }

    var year: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "YYYY"
        let formattedDate = formatter.string(from: self)

        return formattedDate
    }
}
