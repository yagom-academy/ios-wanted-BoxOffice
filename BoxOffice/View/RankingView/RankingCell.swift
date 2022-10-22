//
//  RankingCell.swift
//  BoxOffice
//
//  Created by sole on 2022/10/18.
//

import UIKit

final class RankingCell: UICollectionViewCell {
    static let nibName = "RankingCell"

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var ratioLabel: UILabel!
    @IBOutlet weak var isIncreasedLabel: UILabel!
    @IBOutlet weak var koreanNameLabel: UILabel!
    @IBOutlet weak var releasedDateLabel: UILabel!
    @IBOutlet weak var dailyAttendanceLabel: UILabel!
    @IBOutlet weak var gradientBlackView: UIImageView!
    @IBOutlet weak var slashImageView: UIImageView!
    @IBOutlet weak var compareToYesterdayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        appearanceOfPosterImageView()
    }
    
    override func prepareForReuse() {
        posterImageView.image = nil
        rankingLabel.text = nil
        ratioLabel.text = nil
        isIncreasedLabel.text = nil
        koreanNameLabel.text = nil
        releasedDateLabel.text = nil
        dailyAttendanceLabel.text = nil
        slashImageView.isHidden = true
    }
    
    func configure(with item: Movie) {
        // posterPath가 있으면
        if let posterPath = item.posterPath {
            // cached image 있으면
            if let poster = CacheManager.searchCachedImage(with: posterPath) {
                posterImageView.image = poster
            // cache image 없으면
            } else {
                Task(priority: .userInitiated, operation: {
                    async let poster = CacheManager.imageCacheAndGet(with: posterPath)
                    posterImageView.image = try await poster
                })
            }
        }
        
        // posterPath가 없으면
        if item.posterPath == nil {
            Task(priority: .userInitiated) {
                posterImageView.image = UIImage(named: "noImage")
                slashImageView.isHidden = false
            }
        }
        
        if item.isNewInRank == .new {
            compareToYesterdayLabel.isHidden = true
            ratioLabel.isHidden = true
            isIncreasedLabel.text = "진입"
        } else {
            ratioLabel.text = "\(item.ratioComparedToYesterday)"
            isIncreasedLabel.text = item.isIncreased.stringType
        }
        rankingLabel.text = "\(item.rank)"
        koreanNameLabel.text = item.name
        releasedDateLabel.text = item.releasedDate.converToStringTypeForUI + " 개봉"
        dailyAttendanceLabel.text = item.dailyAudience.convertDecimalStringType + "명 관람"
    }
    
    private func appearanceOfPosterImageView() {
        posterImageView.isCorner(radius: 10)
        gradientBlackView.isCorner(radius: 10)
        slashImageView.isHidden = true
    }
    
    static func nib() -> UINib {
        return UINib(nibName: RankingCell.nibName, bundle: nil)
    }
}
