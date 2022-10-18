//
//  BoxOfficeViewModel.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/18.
//

import Foundation

struct BoxOfficeViewModel {
    var viewModel: BoxOfficeModel
    var boxofficeType: String
    var showRange: String
    var listModel: [DailyBoxOfficeList]
    
    init(viewModel: BoxOfficeModel) {
        self.viewModel = viewModel
        self.boxofficeType = viewModel.boxOfficeResult.boxofficeType
        self.showRange = viewModel.boxOfficeResult.showRange
        self.listModel = viewModel.boxOfficeResult.dailyBoxOfficeList
    }
    
    func boxOffice(row: Int) -> DailyBoxOfficeList{
        return self.listModel[row]
    }
    
    func listCount() -> Int {
        self.listModel.count
    }
    
    func rankChange(row: Int) -> String {
        if self.listModel[row].rankOldAndNew == .new {
            return RankOldAndNew.new.rawValue
        }
        return self.listModel[row].rankInten
    }
}
