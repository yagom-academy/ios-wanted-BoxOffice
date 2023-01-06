//
//  MovieButton.swift
//  BoxOffice
//
//  Created by Judy on 2023/01/06.
//

import UIKit

final class MoviewButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.backgroundColor = .systemGray6
            } else {
                self.backgroundColor = .systemBackground
            }
        }
    }
    
    init(title: String = "", frame: CGRect = .zero) {
        super.init(frame: frame)
        setupButton(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.label, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
