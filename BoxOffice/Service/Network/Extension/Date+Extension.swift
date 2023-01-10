//
//  Date+Extension.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/04.
//

import Foundation

extension Date {
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter
    }
    
    var calendar: Calendar {
        return Calendar.current
    }
    
    func toString() -> String {
        dateFormatter.string(from: self)
    }
    
    func toDate(from dateText: String) -> Date {
        guard let date = dateFormatter.date(from: dateText) else {
            return Date()
        }
        return date
    }
    
    func previousDate(to day: Int) -> Date {
        guard let previousDate = calendar.date(byAdding: .day, value: day, to: Date()) else {
            return Date()
        }
        return previousDate
    }
}
