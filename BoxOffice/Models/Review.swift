//
//  Review.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/18.
//

import Foundation

struct Review: Hashable {
    private let uuid = UUID()
    let nickname: String
    let password: String
    let rating: Int
    let content: String
    //    let image: String
}

extension Review {
    static var sampleData: [Review] = [
        Review(nickname: "aaa", password: "123", rating: 5, content: "aaa gogogo"),
        Review(nickname: "aaa", password: "123", rating: 5, content: "aaa gogogo"),
        Review(nickname: "aaa", password: "123", rating: 5, content: "aaa gogogo"),
        Review(nickname: "aaa", password: "123", rating: 5, content: "aaa gogogo"),
        Review(nickname: "aaa", password: "123", rating: 5, content: "aaa gogogo"),
    ]
}
