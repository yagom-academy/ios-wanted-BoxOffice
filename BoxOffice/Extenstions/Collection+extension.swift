//
//  Collection+extension.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/19.
//

import Foundation
extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
