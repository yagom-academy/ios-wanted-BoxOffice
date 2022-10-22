//
//  PaddingLabel.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/18.
//

import UIKit

class PaddingLabel : UILabel {
    private var padding = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize{
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width  += padding.left + padding.right
        return contentSize
    }
    
    convenience init(padding : UIEdgeInsets){
        self.init()
        self.padding = padding
    }

}

