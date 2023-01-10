//
//  MovieLabel.swift
//  BoxOffice
//
//  Created by Judy on 2023/01/05.
//

import UIKit

final class MovieLabel: UILabel {
    init(font: UIFont.TextStyle, isBold: Bool = false, frame: CGRect = .zero) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = .preferredFont(forTextStyle: font)
        
        if isBold {
            self.font = .boldSystemFont(ofSize: self.font.pointSize)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
