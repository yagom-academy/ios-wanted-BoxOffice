//
//  GradientOverlayedImageView.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/19.
//

import Foundation
import UIKit
// MARK: - View
class OverlayedImageView: UIImageView {
    // MARK: View Components
    let overlayedLayer: CALayer
    
    // MARK: Properties
    var didSetupConstraints = false
    
    // MARK: Life Cycle
    init(layer: CALayer) {
        self.overlayedLayer = layer
        super.init(frame: .zero)
        self.layer.addSublayer(overlayedLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        overlayedLayer.frame = self.bounds
        CATransaction.commit()
    }
}
