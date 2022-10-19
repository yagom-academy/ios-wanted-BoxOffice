//
//  RankingCell.swift
//  BoxOffice
//
//  Created by sole on 2022/10/18.
//

import UIKit

class RankingCell: UICollectionViewCell {
    static let nibName = "RankingCell"

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var ratioComparedToYesterdayLabel: UILabel!
    @IBOutlet weak var isIncreasedLabel: UILabel!
    @IBOutlet weak var koreanNameLabel: UILabel!
    @IBOutlet weak var releasedDateLabel: UILabel!
    @IBOutlet weak var dailyAttendanceLabel: UILabel!
    
    @IBOutlet weak var gradientBlackView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        appearanceOfPosterImageView()
    }
    
    override func prepareForReuse() {
        posterImageView.image = nil
        rankingLabel.text = nil
        ratioComparedToYesterdayLabel.text = nil
        isIncreasedLabel.text = nil
        koreanNameLabel.text = nil
        releasedDateLabel.text = nil
        dailyAttendanceLabel.text = nil 
    }
    
    func configure(with item: MockData) {
        posterImageView.image = UIImage(named: "poster.png")
        rankingLabel.text = "\(item.ranking)"
        ratioComparedToYesterdayLabel.text = "\(item.inOrDecreaseComparedYesterday)"
        isIncreasedLabel.text = "up↑"
        koreanNameLabel.text = item.koreanName
        releasedDateLabel.text = item.releasedDate
        dailyAttendanceLabel.text = "\(item.dailyAttendance)"
    }
    
    private func appearanceOfPosterImageView() {
        posterImageView.layer.cornerRadius = 10
        posterImageView.clipsToBounds = true
        gradientBlackView.layer.cornerRadius = 10
        gradientBlackView.clipsToBounds = true
    }
    
    static func nib() -> UINib {
        return UINib(nibName: RankingCell.nibName, bundle: nil)
    }
}
