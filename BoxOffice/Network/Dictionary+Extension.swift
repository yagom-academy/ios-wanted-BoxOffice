//
//  Dictionary+Extension.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/02.
//

extension Dictionary {
    var queryString: String {
        return self.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
    }
}
