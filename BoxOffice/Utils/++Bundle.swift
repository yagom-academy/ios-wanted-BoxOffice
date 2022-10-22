//
//  ++Bundle.swift
//
//  Created by 유영훈 on 2022/10/17.
//

import Foundation

extension Bundle {
    var apikey: String {
        guard let file = self.path(forResource: "BoxOffice", ofType: "plist") else { return "" }
        guard let resource = try? NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["API_KEY"] as? String else {
            fatalError("Add API KEY to BoxOffice.plist")
        }
        return key
    }
}
