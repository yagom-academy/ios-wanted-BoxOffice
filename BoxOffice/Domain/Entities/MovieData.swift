//
//  MovieDetail.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/02.
//

import UIKit

struct MovieData: Hashable {
    let uuid: UUID
    let poster: UIImage?
    let currentRank: String
    let title: String
    let openDate: String
    let totalAudience: String
    let rankChange: String
    let isNewEntry: Bool
    let productionYear: String
    let openYear: String
    let showTime: String
    let genreName: String
    let directorName: String
    let actors: [String]
    let ageLimit: String
}
