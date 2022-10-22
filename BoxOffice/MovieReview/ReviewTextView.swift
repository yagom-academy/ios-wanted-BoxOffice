//
//  ReviewTextView.swift
//  BoxOffice
//
//  Created by Julia on 2022/10/20.
//

import UIKit

protocol ReviewTextViewDelegate: AnyObject {
    func textFieldEditEnd(title: String, text: String)
}

final class ReviewTextView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.text = "ggd"
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    weak var delegate: ReviewTextViewDelegate?

    init() {
        super.init(frame: .zero)
        self.setUpLayouts()
        self.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
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
    
    @objc func textFieldDidChange(_ sender: UIButton) {
        delegate?.textFieldEditEnd(title: titleLabel.text ?? "", text: textField.text ?? "")
    }
    
}
