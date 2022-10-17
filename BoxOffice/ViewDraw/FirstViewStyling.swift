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
    var cellTimeLabelStyling: (UILabel) -> () {
        {
            $0.textColor = .graySecondary
            $0.font = .appleSDGothicNeo(weight: .regular, size: 12)
            $0.textAlignment = .left
            $0.text = "2022/09/08 14:50:43"
        }
    }
    
    var cellMeasureTypelabelStyling: (UILabel) -> () {
        {
            $0.textColor = .grayPrimary
            $0.font = .appleSDGothicNeo(weight: .regular, size: 18)
            $0.textAlignment = .left
            $0.text = "GYRO"
        }
    }
    
    var cellAmountTypeLabelStyling: (UILabel) -> () {
        {
            $0.textColor = .grayPrimary
            $0.font = .appleSDGothicNeo(weight: .regular, size: 28)
            $0.textAlignment = .center
            $0.text = "60.0"
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
