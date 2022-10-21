//
//  FirstViewStyling.swift
//  BoxOffice
//
//  Created by sokol on 2022/10/17.
//

import Foundation
import UIKit

protocol FirstViewStyling { }

extension FirstViewStyling {
    
    var cellPosterImageViewStyling: (UIImageView) -> () {
        {
            $0.layer.cornerRadius = 12
            $0.layer.shadowColor = UIColor(red: 0.271, green: 0.357, blue: 0.388, alpha: 0.2).cgColor
            $0.layer.shadowOpacity = 1
            $0.layer.shadowOffset = CGSize(width: 0, height: 1)
            $0.layer.shadowRadius = 8
            $0.image = UIImage(systemName: .docImage)
        }
    }
    
    var cellPresentRankLabelStyling: (UILabel) -> () {
        {
            $0.textColor = .graySecondary
            $0.font = .appleSDGothicNeo(weight: .bold, size: 16)
            $0.textAlignment = .left
            $0.text = "1"
        }
    }
    
    var cellMovieNameLabelStyling: (UILabel) -> () {
        {
            $0.textColor = .grayPrimary
            $0.font = .appleSDGothicNeo(weight: .regular, size: 18)
            $0.textAlignment = .left
            $0.text = "무비네임"
        }
    }
    
    var cellRelesedDateLabelStyling: (UILabel) -> () {
        {
            $0.textColor = .grayPrimary
            $0.font = .appleSDGothicNeo(weight: .regular, size: 14)
            $0.textAlignment = .left
            $0.text = "2022/09/08 14:50:43"
        }
    }
    
    var cellWatchedCustomerCountLabelStyling: (UILabel) -> () {
        {
            $0.textColor = .graySecondary
            $0.font = .appleSDGothicNeo(weight: .regular, size: 14)
            $0.textAlignment = .left
            $0.text = "100000000"
        }
    }
    
    var cellRankIncrementLabelStyling: (UILabel) -> () {
        {
            $0.textColor = .grayPrimary
            $0.font = .appleSDGothicNeo(weight: .regular, size: 14)
            $0.textAlignment = .left
            $0.text = "100000000"
        }
    }
    
    var cellApproachedRankIndexLabel: (UILabel) -> () {
        {
            $0.textColor = .graySecondary
            $0.font = .appleSDGothicNeo(weight: .regular, size: 14)
            $0.textAlignment = .left
            $0.text = "100000000"
        }
    }
    
    var cellVerticalStackViewStyling: (UIStackView) -> () {
        {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.spacing = 4.0
        }
    }
    
    var cellActivityIndicatorViewStyling: (UIActivityIndicatorView) -> () {
        {
            $0.style = .large
            $0.color = .grayPrimary
            $0.isHidden = false
        }
    }
}
