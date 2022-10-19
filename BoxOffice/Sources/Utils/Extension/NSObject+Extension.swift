//
//  NSObject+Extension.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/19.
//

import Foundation

extension NSObject {
    static var className: String! {
        return String(describing: self).components(separatedBy: ".").last
    }
}
