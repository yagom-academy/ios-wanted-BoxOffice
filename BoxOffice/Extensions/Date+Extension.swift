//
//  Date+Extension.swift
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

    var year: Int {
        get {
            return calendar.component(.year, from: self)
        }
        set {
            guard newValue > 0 else { return }
            let currentYear = calendar.component(.year, from: self)
            let yearsToAdd = newValue - currentYear
            if let date = calendar.date(byAdding: .year, value: yearsToAdd, to: self) {
                self = date
            }
        }
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
