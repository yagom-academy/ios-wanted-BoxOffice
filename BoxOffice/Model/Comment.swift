//
//  Comment.swift
//  BoxOffice
//
//  Created by 우롱차 on 2023/01/03.
//

import Foundation

protocol FireStoreDatable: Codable {
    var collection: String { get }
    var document: String { get }
    var toTupleData: [String: Any] { get }
}

struct Comment: FireStoreDatable, Hashable {
    
    let id: String
    let date: String
    let movieCd: String
    let nickName: String
    let password: String
    let rate: Double
    let info: String
    let picture: String
    
    init(id: String = UUID().uuidString, date: String = Date().now, movieCd: String, nickName: String, password: String, rate: Double, info: String, picture: String) {
        self.id = id
        self.date = date
        self.movieCd = movieCd
        self.nickName = nickName
        self.password = password
        self.rate = rate
        self.info = info
        self.picture = picture
    }
    
    var collection: String {
        return movieCd
    }
    
    var document: String {
        return id
    }
    
    var toTupleData: [String : Any] {
        let data: [String : Any]  = [
            "id" : id,
            "date" : date,
            "movieCd" : movieCd,
            "nickName" : nickName,
            "password" : password,
            "rate" : rate,
            "info" : info,
            "picture" : picture
        ]
        
        return data
    }
}

