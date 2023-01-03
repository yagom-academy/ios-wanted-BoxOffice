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

struct Comment: FireStoreDatable {
    
    let id: UUID
    let date: Date
    let movieCd: String
    let nickName: String
    let password: String
    let rate: Double
    let info: String
    let picture: String
    
    var collection: String {
        return movieCd
    }
    
    var document: String {
        return id.uuidString
    }
    
    var toTupleData: [String : Any] {
        let data: [String : Any]  = [
            "id" : id.uuidString,
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

