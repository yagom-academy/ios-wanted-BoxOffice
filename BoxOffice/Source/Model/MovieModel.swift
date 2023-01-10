//
//  MovieModel.swift
//  BoxOffice
//
//  Created by seohyeon park on 2023/01/05.
//

import Foundation

// MARK: 영화 모든 정보 DTO
struct MovieModel {
    var boxOfficeInfo: BoxOfficeInfo
    var movieInfo: DetailInfo
    var posterURL: String?
}
