//
//  MovieDetailViewModel.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/02.
//

import Foundation

final class MovieDetailViewModel {
    var tabBarMode: TabBarMode = .movieInfo
}

extension MovieDetailViewModel {
    enum TabBarMode {
        case movieInfo
        case review
    }
}
