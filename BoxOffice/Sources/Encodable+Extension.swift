//
//  Encodable+Extension.swift
//  BoxOffice
//
//  Created by 이예은 on 2023/01/03.
//

import Foundation

extension Encodable {
    var asDictionary: [String: Any]? {
        guard let object = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: object, options: []) as? [String: Any] else { return nil }
        return dictionary
    }
}
