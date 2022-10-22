//
//  Review.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/21.
//

import Foundation
import UIKit

struct Review: Codable, Equatable {
    var nickname: String
    var photo: Data?
    var rating: Int
    var password: String
    var content: String
}

extension Review {
    static var dummyReview: Review {
        return Review(
            nickname: "별명이 들어갑니다",
            photo: UIImage(named: "circle")?.jpegData(compressionQuality: 0.25),
            rating: 5,
            password: "#123abcd".sha256()!,
            content: "리뷰 내용이 여기에 들어갑니다. 리뷰 내용은 여기에 들어가요. 리뷰 내용은 여기 들어갑니다. 리뷰 내용이 여기에 들어가요. 리뷰 내용은 여기에 들어가요. 리뷰 내용은 여기 들어간다구요. 리뷰 내용이 여기에 들어갑니다. 리뷰 내용은 여기에 들어가요. 리뷰 내용은 여기 들어갑니다. 리뷰 내용이 여기에 들어가요. 리뷰 내용은 여기에 들어가요. 리뷰 내용은 여기 들어간다구요.")
    }
}
