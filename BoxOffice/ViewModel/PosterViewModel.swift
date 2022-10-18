//
//  PosterViewModel.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/19.
//

import Foundation

struct PosterViewModel {
    
    var posterList: [PosterModel]
    
    init(posterList: [PosterModel]) {
        self.posterList = posterList
    }
}
