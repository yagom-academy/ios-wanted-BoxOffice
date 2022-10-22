//
//  MoviePosterData.swift
//  BoxOffice
//
//  Created by KangMingyo on 2022/10/20.
//

import Foundation

struct MoviePosterData : Codable {
    let results : [Results]
}

struct Results : Codable {
    let poster_path : String?
}
