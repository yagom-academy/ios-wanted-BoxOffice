//
//  Data+Extension.swift
//  BoxOffice
//
//  Created by bard on 2023/01/02.
//

import Foundation

extension Data {
    mutating func append(_ text: String) {
        guard let data = text.data(using: .utf8) else { return }
        
        self.append(data)
    }

    func decodeData<T: Decodable>(type: T.Type) -> T? {
        let jsonDecoder = JSONDecoder()
        var data: T?
        
        data = try? jsonDecoder.decode(type.self, from: self)
        
        return data
    }
    
    func encodeData<T: Encodable>(type: T) -> Data {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(type.self) else {  return Data() }
        
        return data
    }
}
