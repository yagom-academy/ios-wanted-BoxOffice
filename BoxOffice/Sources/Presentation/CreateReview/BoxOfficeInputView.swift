//
//  BoxOfficeInputView.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/04.
//

import UIKit

final class BoxOfficeInputView: UIView {
    
    override var intrinsicContentSize: CGSize {
        return .init(width: -1.0, height: 44)
    }
    
    private lazy var backgroundStackView: UIStackView = {
        let stackView = UIStackView(axis: .horizontal, alignment: .fill, distribution: .fill, spacing: 70)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 11, leading: 16, bottom: 11, trailing: 0)
        stackView.addArrangedSubviews(titleLabel, textField)
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(for: .body, weight: .semibold)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.heightAnchor.constraint(equalToConstant: 22).isActive = true
        textField.tintColor = .label.withAlphaComponent(0.9)
        textField.clearButtonMode = .always
        textField.borderStyle = .none
        textField.font = .preferredFont(forTextStyle: .body)
        textField.backgroundColor = .boBackground
        return textField
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    private func configure() {
        addSubviews(backgroundStackView, lineView)
        NSLayoutConstraint.activate([
            backgroundStackView.topAnchor.constraint(equalTo: topAnchor),
            backgroundStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.3),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
}

extension BoxOfficeInputView {
    
    convenience init(title: String, placeholder: String) {
        self.init(frame: .zero)
        configure()
        titleLabel.text = title
        textField.placeholder = placeholder
    }
    
}
