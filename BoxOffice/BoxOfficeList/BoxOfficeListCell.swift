//
//  BoxOfficeListCell.swift
//  BoxOffice
//
//  Created by YunYoungseo on 2023/01/02.
//

import UIKit

class BoxOfficeListCell: UICollectionViewListCell {
    var viewModel: BoxOfficeListCellViewModel?

    override func updateConfiguration(using state: UICellConfigurationState) {
        let config = BoxOfficeListContentConfiguration(
            movieName: viewModel?.movieName,
            lank: viewModel?.lank,
            openDate: viewModel?.openDate,
            audienceCount: viewModel?.audienceCount,
            increaseOrDecreaseInRank: viewModel?.increaseOrDecreaseInRank,
            isNewEntryToRank: viewModel?.isNewEntryToRank
        ).updated(for: state)
        contentConfiguration = config
    }
}
