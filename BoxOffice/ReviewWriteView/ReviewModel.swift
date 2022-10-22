//
//  ReviewModel.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/22.
//

import UIKit

struct ReviewModel : Codable{
    let id : String
    let pw : String
    let comment : String
    let rating : Double
    let profile : String?
}

struct Review{
    let review : ReviewModel
    let profile : UIImage
}
