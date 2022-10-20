//
//  TrailerCell.swift
//  BoxOffice
//
//  Created by sole on 2022/10/19.
//

import UIKit

final class TrailerCell: UICollectionViewCell {
    static let nibName = "TrailerCell"
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var ratioComparedToYesterdayLabel: UILabel!
    @IBOutlet weak var isIncreasedLabel: UILabel!
    @IBOutlet weak var koreanNameLabel: UILabel!
    @IBOutlet weak var englishNameLabel: UILabel!
    @IBOutlet weak var releasedDateLabel: UILabel!
    @IBOutlet weak var totalAttendanceLabel: UILabel!
    @IBOutlet weak var playImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        backdropImageView.image = nil
        posterImageView.image = nil
        rankingLabel.text = nil
        ratioComparedToYesterdayLabel.text = nil
        isIncreasedLabel.text = nil
        koreanNameLabel.text = nil
        englishNameLabel.text = nil
        releasedDateLabel.text = nil
        totalAttendanceLabel.text = nil
        playImageView.image = UIImage(systemName: "play")
    }
    
    func configure(with mockData: MainInformation) {
        backdropImageView.image = UIImage(named: "testImage1")
        posterImageView.image = UIImage(named: "poster")
        rankingLabel.text = "\(mockData.ranking)"
        ratioComparedToYesterdayLabel.text = "\(mockData.ratioComparedToYesterday)"
        isIncreasedLabel.text = "up↑↑"
        koreanNameLabel.text = mockData.koreanName
        englishNameLabel.text = mockData.englishName
        releasedDateLabel.text = mockData.releasedDate
        totalAttendanceLabel.text = "누적관객수 83,017명"
    }
    
    static func nib() -> UINib {
        return UINib(nibName: TrailerCell.nibName, bundle: nil)
    }
}
