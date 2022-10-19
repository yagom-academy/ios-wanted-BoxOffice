//
//  BoxOfficeCellViewModel.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/19.
//

import UIKit

class BoxOfficeCellViewModel: TableViewCellViewModel {
    static var identifier: String = String(describing: BoxOfficeTableViewCell.self)
    let cellData: DailyBoxOfficeList
    var posterURL: String
    
    init(cellData: DailyBoxOfficeList, posterURL: String) {
        self.cellData = cellData
        self.posterURL = posterURL
    }
    
}
