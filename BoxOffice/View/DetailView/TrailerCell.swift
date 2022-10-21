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
    @IBOutlet weak var gradientBlackImageView: UIImageView!
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var ratioComparedToYesterdayLabel: UILabel!
    @IBOutlet weak var isIncreasedLabel: UILabel!
    @IBOutlet weak var koreanNameLabel: UILabel!
    @IBOutlet weak var englishNameLabel: UILabel!
    @IBOutlet weak var releasedDateLabel: UILabel!
    @IBOutlet weak var totalAttendanceLabel: UILabel!
    @IBOutlet weak var playImageView: UIImageView!
    @IBOutlet weak var slashImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        appearanceOfPosterImageView()
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
        slashImageView.isHidden = true
    }
    
    func configure(with mockData: MainInfo) {
        if mockData.posterPath == nil {
            posterImageView.image = UIImage(named: "noImage")
            slashImageView.isHidden = false
        }
        if mockData.backdropPath == nil {
            backdropImageView.image = UIImage(named: "noTrailer")
            playImageView.image = UIImage(systemName: "play.slash")
        }
        backdropImageView.image = UIImage(named: "noTrailer")
        posterImageView.image = UIImage(named: "noImage")
        rankingLabel.text = "\(mockData.rank)"
        ratioComparedToYesterdayLabel.text = "\(mockData.ratioComparedToYesterday)"
        isIncreasedLabel.text = "up↑↑"
        koreanNameLabel.text = mockData.name
        englishNameLabel.text = mockData.nameInEnglish
        releasedDateLabel.text = mockData.releasedDate.converToStringTypeForUI
        totalAttendanceLabel.text = "누적관객수 83,017명"
    }
    
    static func nib() -> UINib {
        return UINib(nibName: TrailerCell.nibName, bundle: nil)
    }
    
    private func appearanceOfPosterImageView() {
        posterImageView.layer.cornerRadius = 10
        posterImageView.clipsToBounds = true
        gradientBlackImageView.layer.cornerRadius = 10
        gradientBlackImageView.clipsToBounds = true
        slashImageView.isHidden = true
    }
}
