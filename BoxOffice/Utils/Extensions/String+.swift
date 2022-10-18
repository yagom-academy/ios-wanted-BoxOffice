//
//  String+.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/17.
//

import Foundation

extension String {

    func date(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }

    var int: Int? {
        return Int(self)
    }
    
}
