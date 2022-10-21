//
//  DetailMovieInfoEntity.swift
//  BoxOffice
//
//  Created by 권준상 on 2022/10/20.
//

import UIKit

struct DetailMovieInfoEntity: Hashable {
    var simpleInfo: SimpleMovieInfoEntity?
    var productYear: String
    var showTime: String
    var openYear: String
    var genreName: [String]
    var directors: String
    var actors: [String]
    var watchGrade: String
}
