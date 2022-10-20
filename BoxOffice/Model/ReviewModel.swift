//
//  ReviewModel.swift
//  BoxOffice
//
//  Created by so on 2022/10/20.
//

import Foundation
import UIKit

struct ReviewModel {
    let 이미지 : UIImage?
    let 닉네임 : String
    let 리뷰 : String
    init(이미지: UIImage?, 닉네임: String, 리뷰: String) {
        self.이미지 = 이미지
        self.닉네임 = 닉네임
        self.리뷰 = 리뷰
    }
}
