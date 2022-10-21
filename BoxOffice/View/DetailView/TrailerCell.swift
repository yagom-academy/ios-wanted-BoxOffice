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
    
    func configure(with item: MainInfo) {
        if let posterPath = item.posterPath,
           let backdropPath = item.backdropPath {
            Task(priority: .userInitiated, operation: {
                async let poster = try ImageManager.fetchImage(posterPath)
                async let backdrop = try ImageManager.fetchImage(backdropPath)
                posterImageView.image = try await poster
                backdropImageView.image = try await backdrop
            })
        } else {
            posterImageView.image = UIImage(named: "noImage")
            slashImageView.isHidden = false
            backdropImageView.image = UIImage(named: "noTrailer")
            playImageView.image = UIImage(systemName: "play.slash")
        }
        rankingLabel.text = "\(item.rank)"
        ratioComparedToYesterdayLabel.text = "\(item.ratioComparedToYesterday)"
        isIncreasedLabel.text = "up↑↑"
        koreanNameLabel.text = item.name
        englishNameLabel.text = item.nameInEnglish
        releasedDateLabel.text = item.releasedDate.converToStringTypeForUI
        totalAttendanceLabel.text = "누적관객수 \(item.totalAudience.convertDecimalStringType())명"
    }
    
    static func nib() -> UINib {
        return UINib(nibName: TrailerCell.nibName, bundle: nil)
    }
    
    private func appearanceOfPosterImageView() {
        posterImageView.isCorner(radius: 10)
        gradientBlackImageView.isCorner(radius: 10)
        slashImageView.isHidden = true
    }
}
