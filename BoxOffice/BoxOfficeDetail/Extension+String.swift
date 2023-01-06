//
//  Extension+String.swift
//  BoxOffice
//
//  Created by Baek on 2023/01/04.
//

import Foundation

extension String {
    func replace(string:String, replacement:String) -> String {
            return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
        }
    
    func removeWhiteSpace() -> String {
        return self.replace(string: " ", replacement: "")
    }
}
