//
//  LoadingView.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/05.
//

import UIKit

final class LoadingView: UIActivityIndicatorView {
    
    convenience init(backgroundColor: UIColor, alpha: CGFloat) {
        self.init(frame: .zero)
        self.style = UIActivityIndicatorView.Style.large
        self.backgroundColor = backgroundColor
        self.alpha = alpha
    }
    
}
