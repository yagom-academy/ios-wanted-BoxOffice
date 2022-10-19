//
//  KeyedDecodingContainer+.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/17.
//

import Foundation

extension KeyedDecodingContainer {

    func decodeStringAsDate(forKey key: Key, withFormat format: String = "yyyy-MM-dd") -> Date? {
        guard let stringValue = try? decode(String.self, forKey: key),
              let dateValue = stringValue.date(withFormat: format) else {
            return nil
        }
        return dateValue
    }

    func decodeStringAsInt(forKey key: Key) -> Int? {
        guard let stringValue = try? decode(String.self, forKey: key),
              let intValue = stringValue.int else {
            return nil
        }
        return intValue
    }

    func decodeStringAsBool(forKey key: Key) -> Bool? {
        if let stringValue = try? decode(String.self, forKey: key) {
            if stringValue == "NEW" {
                return true
            } else if stringValue == "OLD" {
                return false
            }
        }
        return nil
    }
    
}
