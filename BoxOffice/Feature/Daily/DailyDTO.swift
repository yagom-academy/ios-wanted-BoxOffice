//
//  DailyDTO.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/21.
//

import Foundation

struct DailyDTO {
    
    var dataSource: [(section: SectionItem, items: [RowItem])]
    
    enum SectionItem: Equatable {
        case dateSelector
        case boxOffice
        
        static func == (lhs: SectionItem, rhs: SectionItem) -> Bool {
            switch (lhs, rhs) {
            case (.dateSelector, .dateSelector):
                return true
            case (.boxOffice, .boxOffice):
                return true
            default:
                return false
            }
        }
    }
    
    enum RowItem: Equatable {
        case dateSelector
        case boxOffice(BoxOfficeData)
        
        static func == (lhs: RowItem, rhs: RowItem) -> Bool {
            switch (lhs, rhs) {
            case (.dateSelector, .dateSelector):
                return true
            case (.boxOffice(let lhs), .boxOffice(let rhs)):
                return lhs == rhs
            default:
                return false
            }
        }
    }
}
