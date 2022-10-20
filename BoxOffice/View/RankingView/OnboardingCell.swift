//
//  OnboardingCell.swift
//  BoxOffice
//
//  Created by sole on 2022/10/19.
//

import UIKit

final class OnboardingCell: UICollectionViewCell {
    static let nibName = "OnboardingCell"

    @IBOutlet weak var onboardingImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        onboardingImageView.image = nil
    }
    
    func configure(with onboarding: Banner) {
        onboardingImageView.image = onboarding.image
    }
    
    static func nib() -> UINib {
        return UINib(nibName: OnboardingCell.nibName, bundle: nil)
    }
}
