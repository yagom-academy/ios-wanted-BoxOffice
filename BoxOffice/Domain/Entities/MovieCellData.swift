//
//  MovieCellData.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/02.
//

import Foundation

struct MovieCellData: Hashable {
    let uuid: UUID
    let posterURL: URL?
    let currentRank: String
    let totalAudience: String
    let title: String
    let openDate: String
    let isNewEntry: Bool
    let rankChange: String
}
