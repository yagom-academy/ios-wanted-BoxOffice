//
//  Date+.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/17.
//

import Foundation

extension Date {

    var calendar: Calendar { Calendar.current }

    var yesterday: Date {
        return calendar.date(byAdding: .day, value: -1, to: self) ?? Date()
    }

    var lastWeek: Date {
        return calendar.date(byAdding: .day, value: -7, to: self) ?? Date()
    }

    func string(withFormat format: String = "yyyyMMdd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    func dateString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = style
        dateFormatter.locale = Locale(identifier: "ko_kr")
        return dateFormatter.string(from: self)
    }
    
}
