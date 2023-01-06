//
//  LoginModel.swift
//  BoxOffice
//
//  Created by seohyeon park on 2023/01/06.
//

import Foundation

struct LoginModel: Codable {
    let image: String
    let nickname: String
    let password: String
    let star: Int
    let content: String
    
    init(image: String, nickname: String, password: String, star: Int, content: String) {
        self.image = image
        self.nickname = nickname
        self.password = password
        self.star = star
        self.content = content
    }
}
