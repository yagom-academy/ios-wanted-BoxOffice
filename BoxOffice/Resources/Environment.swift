//
//  Environment.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/18.
//

import Foundation

struct Environment {
    static let kobisKey = Bundle.main.object(forInfoDictionaryKey: "KOBIS_KEY") as! String
}
