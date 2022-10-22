//
//  DetailDTO.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/22.
//

import Foundation

struct DetailDTO {
    var dataSource: [(section: SectionItem, items: [RowItem])]
    
    enum SectionItem: Equatable {
        case movieInfo
        
        static func == (lhs: SectionItem, rhs: SectionItem) -> Bool {
            switch (lhs, rhs) {
            case (.movieInfo, .movieInfo):
                return true
            }
        }
    }
    
    enum RowItem: Equatable {
        case movieInfoWithBoxOffice(BoxOfficeData)
        case movieInfo(MovieInfoData)
        
        static func == (lhs: RowItem, rhs: RowItem) -> Bool {
            switch (lhs, rhs) {
            case (.movieInfoWithBoxOffice(let lhs), .movieInfoWithBoxOffice(let rhs)):
                return lhs == rhs
            case (.movieInfo(let lhs), .movieInfo(let rhs)):
                return lhs == rhs
            default:
                return false
            }
        }
    }
}
