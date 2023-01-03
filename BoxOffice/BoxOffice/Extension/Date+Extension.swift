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
        formatter.locale = .current
        formatter.dateFormat = "yyyyMMdd"
        let formattedDate = formatter.string(from: self)
        
        return formattedDate
    }
}
