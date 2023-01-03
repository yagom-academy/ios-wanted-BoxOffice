//
//  Encodable+extension.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/03.
//

import Foundation

extension Encodable {
    
    func asDictionary() throws -> [String: Any] {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
    
    func asURLQuerys() throws -> [URLQueryItem] {
        let dictionary = try asDictionary()
        return dictionary.sorted{ $0.key < $1.key }.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
    }
    
}
