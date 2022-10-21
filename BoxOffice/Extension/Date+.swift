//
//  Date+.swift
//  BoxOffice
//
//  Created by sole on 2022/10/21.
//

import UIKit

extension Date {
    var convertToStringTypeForSearch: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let string = formatter.string(from: self)
        return string
    }
    
    var converToStringTypeForUI: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let string = formatter.string(from: self)
        return string
    }
    
    var yesterday: Date {
        self - 86400
    }
    
    var year: Int {
        let calendar = Calendar.current
        return calendar.component(.year, from: self)
    }
}
