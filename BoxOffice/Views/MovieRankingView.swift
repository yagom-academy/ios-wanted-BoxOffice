//
//  MovieRankingView.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/18.
//

import UIKit

final class MovieRankingView: UIView {

    // MARK: UI

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var openDateLabel: UILabel!
    @IBOutlet var numberOfMoviegoersLabel: UILabel!
    @IBOutlet var rankingLabel: UILabel!
    @IBOutlet var isNewRankingInfoView: UIStackView!
    @IBOutlet var isNewRankingLabel: UILabel!
    @IBOutlet var changeRankingInfoView: UIStackView!
    @IBOutlet var changeRankingLabel: UILabel!
    @IBOutlet var changeRankingImageView: UIImageView!

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        xibSetup()
    }

    private func xibSetup() {
        guard let view = loadViewFromNib(nib: "MovieRankingView") else {
            return
        }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }

    private func loadViewFromNib(nib: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nib, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

    // MARK: -

    func updateView(with movieRanking: MovieRanking) {
        nameLabel.text = movieRanking.name
        openDateLabel.text = "\(movieRanking.openDate.dateString()) 개봉"
        numberOfMoviegoersLabel.text = "누적관객 \(movieRanking.numberOfMoviegoers.string)명"
        rankingLabel.text = movieRanking.ranking.string
        if movieRanking.isNewRanking {
            isNewRankingInfoView.isHidden = false
            isNewRankingLabel.text = "NEW"
        } else {
            isNewRankingInfoView.isHidden = true
        }
        if movieRanking.changeRanking == 0 {
            changeRankingInfoView.isHidden = true
        } else {
            changeRankingInfoView.isHidden = false
            let isRankUp = movieRanking.changeRanking > 0
            let upColor: UIColor = .systemPink
            let downColor: UIColor = .systemBlue
            let upIcon = UIImage(systemName: "arrowtriangle.up.fill")
            let downIcon = UIImage(systemName: "arrowtriangle.down.fill")
            changeRankingLabel.text = movieRanking.changeRanking.string
            if isRankUp {
                changeRankingImageView.image = upIcon
                changeRankingLabel.textColor = upColor
                changeRankingImageView.tintColor = upColor
            } else {
                changeRankingImageView.image = downIcon
                changeRankingLabel.textColor = downColor
                changeRankingImageView.tintColor = downColor
            }
        }
    }

}
