//
//  String+.swift
//  BoxOffice
//
//  Created by sole on 2022/10/21.
//

import Foundation

extension String {
    func convertToDateType() throws -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: self) else {
            throw ConvertError.toDateType
        }
        return date
    }
}
