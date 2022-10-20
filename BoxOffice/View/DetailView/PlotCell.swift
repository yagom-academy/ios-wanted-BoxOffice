//
//  PlotCell.swift
//  BoxOffice
//
//  Created by sole on 2022/10/19.
//

import UIKit

final class PlotCell: UICollectionViewCell {
    static let nibName = "PlotCell"
    
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var openAndCloseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        plotLabel.text = nil
        plotLabel.numberOfLines = 1
        openAndCloseLabel.text = "...더보기"
    }
    
    func configure(with mockData: Plot) {
        plotLabel.text = mockData.content
    }
    
    func appearanceLabel(isOpend: Bool) {
        switch isOpend {
        case true:
            plotLabel.numberOfLines = 0
            openAndCloseLabel.text = "접기"
        case false:
            plotLabel.numberOfLines = 1
            openAndCloseLabel.text = "...더보기"
        }
    }
    
    static func nib() -> UINib {
        return UINib(nibName: PlotCell.nibName, bundle: nil)
    }
}
