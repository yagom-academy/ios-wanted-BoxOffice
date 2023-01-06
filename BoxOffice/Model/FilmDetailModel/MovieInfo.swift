//
//  File.swift
//  BoxOffice
//
//  Created by 박도원 on 2023/01/06.
//

import Foundation

struct MovieInfo: Decodable {
    let movieNmEn: String
    let prdtYear: String
    let openDt: String
    let showTm: String
    let genres: [Genres]
    let directors: [PeopleName]
    let actors: [PeopleName]
    let audits: [Audits]
}
