//
//  JSONManager.swift
//  BoxOffice
//
//  Created by dhoney96 on 2023/01/03.
//

import Foundation

class JSONManager {
    static let shared = JSONManager()
    private let decoder = JSONDecoder()
    
    private init() { }
    
    func decodeToInfo<T: Decodable>(from data: Data) -> T? {
        do {
            let returnData = try self.decoder.decode(T.self, from: data)
            return returnData
        } catch {
            print(error)
            return nil
        }
    }
}
