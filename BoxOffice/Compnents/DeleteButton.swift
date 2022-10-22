//
//  DeleteButton.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/21.
//

import UIKit

class DeleteButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.backgroundColor = .red
                self.setTitleColor(.white, for: .normal)
            } else {
                self.backgroundColor = .white
                self.setTitleColor(.red, for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
