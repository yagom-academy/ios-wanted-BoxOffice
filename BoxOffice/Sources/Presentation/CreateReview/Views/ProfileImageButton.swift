//
//  ProfileImageButton.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/04.
//

import UIKit

final class ProfileImageButton: UIButton {
    
    private var size: CGFloat = 0
    
    override var intrinsicContentSize: CGSize {
        return .init(width: size, height: size)
    }
    
    private lazy var config = UIImage.SymbolConfiguration(pointSize: size)
    
    private lazy var editBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.8)
        return view
    }()
    
    private lazy var editLabel: UIView = {
        let label = UILabel()
        label.textColor = .white
        label.text = "수정"
        label.font = .preferredFont(for: .caption2, weight: .semibold)
        return label
    }()
    
    convenience init(size: CGFloat) {
        self.init(frame: .zero)
        self.size = size
        configure()
    }
    
}

private extension ProfileImageButton {
    
    func configure() {
        tintColor = .label
        clipsToBounds = true
        layer.cornerRadius = size / 2
        backgroundColor = .systemGray
        setImage(
            UIImage(systemName: "person.circle.fill")?
                .withTintColor(.darkGray, renderingMode: .alwaysOriginal)
                .withConfiguration(config),
            for: .normal
        )
        setUpViews()
    }
    
    func setUpViews() {
        addSubviews(editBackgroundView, editLabel)
        NSLayoutConstraint.activate([
            editBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            editBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            editBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            editBackgroundView.heightAnchor.constraint(equalToConstant: 20),
            editLabel.centerXAnchor.constraint(equalTo: editBackgroundView.centerXAnchor),
            editLabel.centerYAnchor.constraint(equalTo: editBackgroundView.centerYAnchor)
        ])
    }
}
