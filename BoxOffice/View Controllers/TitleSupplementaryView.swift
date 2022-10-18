//
//  TitleSupplementaryView.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/18.
//

import UIKit

final class TitleSupplementaryView: UICollectionReusableView {

    // MARK: UI

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberOfMoviegoersLabel: UILabel!
    @IBOutlet var rankingLabel: UILabel!

    @IBOutlet var isNewRankingInfoView: UIStackView!
    @IBOutlet var isNewRankingLabel: UILabel!
    @IBOutlet var changeRankingInfoView: UIStackView!
    @IBOutlet var changeRankingImageView: UIImageView!
    @IBOutlet var changeRankingLabel: UILabel!

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        loadViewFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        loadViewFromNib()
    }

    private func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: TitleSupplementaryView.reuseIdentifier, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }

}
