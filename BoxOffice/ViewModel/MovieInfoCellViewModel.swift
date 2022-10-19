//
//  MovieInfoCellViewModel.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/19.
//

import Foundation

class MovieInfoCellViewModel: TableViewCellViewModel {
    static var identifier: String = String(describing: MovieInfoTableViewCell.self)
    let cellData: MovieInfo
    
    init(cellData: MovieInfo) {
        self.cellData = cellData
    }
    
}
