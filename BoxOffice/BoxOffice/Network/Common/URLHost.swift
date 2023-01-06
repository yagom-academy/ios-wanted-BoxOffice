//
//  URLHost.swift
//  BoxOffice
//
//  Created by bard on 2023/01/02.
//

enum URLHost {
    case kobis
    case OMDB

    var url: String {
        switch self {
        case .kobis:
            return "https://www.kobis.or.kr"
        case .OMDB:
            return "https://www.omdbapi.com/"
        }
    }
}
