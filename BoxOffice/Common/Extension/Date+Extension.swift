//
//  Date+Extension.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/18.
//

import Foundation

extension Date {
    /// "yyyyMMdd"
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter.string(from: self)
    }
}
