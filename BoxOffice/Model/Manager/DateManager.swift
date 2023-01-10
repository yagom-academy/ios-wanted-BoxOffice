//
//  DateManager.swift
//  BoxOffice
//
//  Created by 박도원 on 2023/01/03.
//

import Foundation

struct DateManager {
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        guard let date = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            return ""
        }
        let currentDate = formatter.string(from: date)
        
        return currentDate
    }
}
