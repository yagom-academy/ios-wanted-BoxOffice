//
//  Date+extension.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/18.
//

import Foundation

extension Date {
    func todayToString() -> String {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        guard let day = yesterday else { return "20221010"}
        let strDate = dateFormatter.string(from: day)
        return strDate
    }
    
    func lastWeekToString() -> String {
        let lastWeek = Calendar.current.date(byAdding: .day, value: -7, to: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        guard let day = lastWeek else { return "20221010"}
        let strDate = dateFormatter.string(from: day)
        return strDate
    }
}
