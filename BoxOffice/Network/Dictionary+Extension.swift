//
//  Dictionary+Extension.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/02.
//

import Foundation

extension Dictionary {
    var queryItems: [URLQueryItem] {
        var itemList = [URLQueryItem]()
        for (key, value) in self {
            guard let key = key as? String, let value = value as? String else { break }
            itemList.append(URLQueryItem(name: key, value: value))
        }
        return itemList
    }
}
