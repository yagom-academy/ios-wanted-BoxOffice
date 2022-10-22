//
//  Sections.swift
//  BoxOffice
//
//  Created by sole on 2022/10/18.
//

import UIKit

enum MainSection: Int, CaseIterable {
    case banner
    case ranking
}

enum DetailSection: Int, CaseIterable {
    case main
    case plot
    case detail

    var headerTitle: String? {
        switch self {
        case .main: return nil
        case .plot: return "줄거리"
        case .detail: return "상세정보"
        }
    }
}
