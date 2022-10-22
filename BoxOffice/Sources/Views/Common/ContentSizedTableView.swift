//
//  ContentSizedTableView.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/22.
//

import Foundation
import UIKit

class ContentSizedTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
