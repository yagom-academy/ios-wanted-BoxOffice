//
//  DetailInformationCell.swift
//  BoxOffice
//
//  Created by sole on 2022/10/19.
//

import UIKit

final class DetailInformationCell: UICollectionViewCell {
    static let nibName = "DetailInformationCell"
    
    @IBOutlet weak var productionYearLabel: UILabel!
    @IBOutlet weak var releasedYearLabel: UILabel!
    @IBOutlet weak var runningTimeLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var directorsLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var watchGradeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        productionYearLabel.text = nil
        releasedYearLabel.text = nil
        runningTimeLabel.text = nil
        genreLabel.text = nil
        directorsLabel.text = nil
        actorsLabel.text = nil
        watchGradeLabel.text = nil
    }
    
    func configure(with item: DetailInfo) {
        productionYearLabel.text = "\(item.productionYear)"
        releasedYearLabel.text = "\(item.releasedYear)"
        runningTimeLabel.text = "\(item.runningTime)"
        genreLabel.text = item.genres
        directorsLabel.text = item.directors
        actorsLabel.text = item.actors
        watchGradeLabel.text = item.watchGrade
    }
    
    static func nib() -> UINib {
        return UINib(nibName: DetailInformationCell.nibName, bundle: nil)
    }
}
