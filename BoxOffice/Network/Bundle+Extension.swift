//
//  Bundle+Extension.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/02.
//

import Foundation

extension Bundle {
    var omdbApiKey: String {
        guard let file = self.path(forResource: "MovieInfo", ofType: "plist") else { return "" }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["omdb_API_KEY"] as? String else { fatalError("Movie.plist에 omdb_API_KEY 값을 입력 해주세요.")}
        return key
    }
    
    var kobisApiKey: String {
        guard let file = self.path(forResource: "MovieInfo", ofType: "plist") else { return "" }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["kobis_API_KEY"] as? String else { fatalError("Movie.plist에 kobis_API_KEY 값을 입력 해주세요.")}
        return key
    }
}
