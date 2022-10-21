//
//  ReviewCellViewModel.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/21.
//

import Foundation

class ReviewCellViewModel: TableViewCellViewModel {
    static var identifier: String = String(describing: ReviewCell.self)
    let cellData: Review
    
    init(cellData: Review) {
        self.cellData = cellData
    }
    
}
