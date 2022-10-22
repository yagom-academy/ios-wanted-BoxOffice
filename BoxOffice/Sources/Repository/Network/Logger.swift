//
//  Logger.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/18.
//

import Foundation

class Logger {
    static var lock = NSLock()
    static func logRequest(_ request: URLRequest) {
        lock.lock()
        defer { lock.unlock() }
        print("--------------------------------------------------------")
        print("[Request]: \(request.url?.absoluteString ?? "")")
    }
    
    static func logResponse(_ result: (data: Data, response: URLResponse)) {
        lock.lock()
        defer { lock.unlock() }
        print("[Response Data]: \(result.response.url?.absoluteString ?? "")")
        if let json = try? JSONSerialization.jsonObject(with: result.data, options: .allowFragments) as? [String: Any],
           let data = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted, .sortedKeys, .fragmentsAllowed, .withoutEscapingSlashes]),
           let str = String(data: data, encoding: .utf8) { print(str) }
        print("--------------------------------------------------------")
    }
}
