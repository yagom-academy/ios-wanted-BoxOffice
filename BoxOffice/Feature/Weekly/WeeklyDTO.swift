//
//  WeeklyDTO.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/22.
//

import Foundation

struct WeeklyDTO {
    
    var dataSource: [(section: SectionItem, items: [RowItem])]
    
    enum SectionItem: Equatable {
        case boxOffice
        
        static func == (lhs: SectionItem, rhs: SectionItem) -> Bool {
            switch (lhs, rhs) {
            case (.boxOffice, .boxOffice):
                return true
            }
        }
    }
    
    enum RowItem: Equatable {
        case boxOffice(BoxOfficeData)
        
        static func == (lhs: RowItem, rhs: RowItem) -> Bool {
            switch (lhs, rhs) {
            case (.boxOffice(let lhs), .boxOffice(let rhs)):
                return lhs == rhs
            }
        }
    }
}
