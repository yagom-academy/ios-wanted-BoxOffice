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
    let boxOfficeData: DailyBoxOfficeList
    
    init(cellData: MovieInfo, boxOfficeData: DailyBoxOfficeList) {
        self.cellData = cellData
        self.boxOfficeData = boxOfficeData
    }
    
    func actorList() -> String {
        var list: [String] = []
        cellData.actors.forEach { value in
            list.append(value.peopleNm)
        }
        return list.joined(separator: ",")
    }
    
    func directorList() -> String {
        var list: [String] = []
        cellData.directors.forEach { value in
            list.append(value.peopleNm)
        }
        return list.joined(separator: ",")
    }
    
}
