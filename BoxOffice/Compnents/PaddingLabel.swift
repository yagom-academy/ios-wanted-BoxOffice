//
//  PaddingLabel.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/18.
//

import UIKit

@IBDesignable
class PaddingLabel: UILabel {

    @IBInspectable var topPadding: CGFloat = 0.0
    @IBInspectable var leftPadding: CGFloat = 0.0
    @IBInspectable var bottomPadding: CGFloat = 0.0
    @IBInspectable var rightPadding: CGFloat = 0.0

    convenience init(padding: UIEdgeInsets) {
        self.init()

        self.topPadding = padding.top
        self.leftPadding = padding.left
        self.bottomPadding = padding.bottom
        self.rightPadding = padding.right
    }

    override func drawText(in rect: CGRect) {
        let padding = UIEdgeInsets.init(
            top: topPadding,
            left: leftPadding,
            bottom: bottomPadding,
            right: rightPadding
        )
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += leftPadding + rightPadding
        contentSize.height += topPadding + bottomPadding
        return contentSize
    }

}

