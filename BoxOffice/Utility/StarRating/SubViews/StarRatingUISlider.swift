//
//  StarRatingUISlider.swift
//  BoxOffice
//
//  Created by Judy on 2023/01/04.
//

import UIKit

final class StarRatingUISlider: UISlider {
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let width = self.frame.size.width
        let tapPoint = touch.location(in: self)
        let tapPercent = tapPoint.x / width
        let newValue = self.maximumValue * Float(tapPercent)
        
        if newValue != self.value {
            self.value = newValue
        }
        
        return true
    }
}
