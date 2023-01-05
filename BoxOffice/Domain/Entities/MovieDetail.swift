//
//  MovieDetail.swift
//  BoxOffice
//
//  Created by minsson on 2023/01/02.
//

import UIKit

struct MovieDetail: Hashable {
    var movieCode: String
    var title: String
    var englishTitle: String
    var productionYear: UInt
    var playTime: Double
    var genre: String
    var directorsName: String
    var actorsName: String
    var watchGrade: String
}
