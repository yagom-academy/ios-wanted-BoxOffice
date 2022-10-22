//
//  Int+Extension.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/18.
//

import Foundation

extension Int {
    /// check the HTTP response status code
    var isSuccessCode: Bool {
        switch self {
        case 200...299:
            return true
        default:
            return false
        }
    }
}
