//
//  Int+Extension.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/20.
//

import Foundation

extension Int {
    enum Format {
        case audience
        case showTime
    }
    
    func formattedString(_ format: Format) -> String {
        switch format {
        case .audience:
            if self < 10000 {
                return "\(self)"
            } else if self < 100000000{
                return "\(self/10000)만"
            } else {
                return "\(self/100000000)억"
            }
        case .showTime:
            return "\(self)분"
        }
    }
}
