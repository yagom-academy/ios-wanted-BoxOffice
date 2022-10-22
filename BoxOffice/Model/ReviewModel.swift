//
//  ReviewModel.swift
//  BoxOffice
//
//  Created by so on 2022/10/20.
//

import Foundation
import UIKit

struct ReviewModel {
    let uesrImage : UIImage?
    let nickName : String
    let review : String
    let reViewStar : String
    
    init(uesrImage: UIImage?, nickName: String, review: String, reViewStar: String) {
        self.uesrImage = uesrImage
        self.nickName = nickName
        self.review = review
        self.reViewStar = reViewStar
    }
}
