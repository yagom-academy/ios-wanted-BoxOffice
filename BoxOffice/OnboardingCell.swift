//
//  OnboardingCell.swift
//  BoxOffice
//
//  Created by sole on 2022/10/19.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    static let nibName = "OnboardingCell"

    @IBOutlet weak var onboardingImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .blue
    }
    
    func configure(with onboarding: Onboarding) {
        onboardingImageView.image = onboarding.banner
    }
    
    static func nib() -> UINib {
        return UINib(nibName: OnboardingCell.nibName, bundle: nil)
    }
}
