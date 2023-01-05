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
    func toString() -> String {
        dateFormatter.string(from: self)
    }
}
