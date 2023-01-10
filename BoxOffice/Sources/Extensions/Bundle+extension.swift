//
//  Bundle+extension.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/03.
//

import Foundation
import OSLog

extension Bundle {
    
    var omdbApiKey: String? {
        guard let file = self.path(forResource: "Secrets", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["OMDB_API_KEY"] as? String else {
            os_log(.error, log: .default, "⛔️ OMDB API KEY를 가져오는데 실패하였습니다.")
            return nil
        }
        return key
    }
    
    var kobisApiKey: String? {
        guard let file = self.path(forResource: "Secrets", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["KOBIS_API_KEY"] as? String else {
            os_log(.error, log: .default, "⛔️ KOBIS API KEY를 가져오는데 실패하였습니다.")
            return nil
        }
        return key
    }
    
}
