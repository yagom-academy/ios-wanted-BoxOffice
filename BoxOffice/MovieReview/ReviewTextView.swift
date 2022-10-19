//
//  ReviewTextView.swift
//  BoxOffice
//
//  Created by Julia on 2022/10/20.
//

import UIKit

final class ReviewTextView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.text = "ggd"
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.contentInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        textView.font = .systemFont(ofSize: 12, weight: .regular)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray5.cgColor
        textView.layer.cornerRadius = 10
        return textView
    }()

    init() {
        super.init(frame: .zero)
        self.setUpLayouts()
    }
    
    convenience init(title: String) {
        self.init()
        self.titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayouts() {
        self.addSubViewsAndtranslatesFalse(titleLabel, textField)
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.textField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            self.textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.textField.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
    
}

