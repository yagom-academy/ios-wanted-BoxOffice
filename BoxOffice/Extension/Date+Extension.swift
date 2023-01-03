//
//  Date+Extension.swift
//  BoxOffice
//
//  Created by 우롱차 on 2023/01/04.
//

import Foundation

extension Date {
    static let dateFormatter = DateFormatter()
    var now: String {
        get {
            Date.dateFormatter.string(from: Date())
        }
    }
}
