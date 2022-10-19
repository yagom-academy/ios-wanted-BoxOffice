//
//  Section.swift
//  BoxOffice
//
//  Created by sole on 2022/10/18.
//

import UIKit

enum Section: Int, CaseIterable {
    case onboarding
    case ranking
}

enum Item: Hashable {
    case onboarding(Onboarding)
    case ranking(MockData)
    
    var type: String {
        switch self {
        case .onboarding(_): return "onboarding"
        case .ranking(_): return "ranking"
        }
    }
    
    var ranking: MockData? {
        switch self { 
        case .onboarding(_): return nil
        case .ranking(let mockData): return mockData
        }
    }
}
