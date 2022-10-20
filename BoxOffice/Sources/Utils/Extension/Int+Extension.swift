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
    }
    
    func formattedString(_ format: Format) -> String {
        switch format {
        case .audience:
            if self < 10000 {
                return "\(self)"
            } else {
                return "\(self/10000)만"
            }
        }
    }
}
