//
//  BoxOfficeListContentConfiguration.swift
//  BoxOffice
//
//  Created by YunYoungseo on 2023/01/03.
//

import UIKit

struct BoxOfficeListContentConfiguration: UIContentConfiguration {
    var movieName: String?
    var rank: Int?
    var openDate: Date?
    var audienceCount: Int?
    var increaseOrDecreaseInRank: Int?
    var isNewEntryToRank: Bool?

    func makeContentView() -> UIView & UIContentView {
        return BoxOfficeListContentView(configuration: self)
    }

    func updated(for state: UIConfigurationState) -> Self {
        return self
    }
}
