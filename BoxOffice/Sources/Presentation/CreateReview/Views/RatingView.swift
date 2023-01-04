//
//  RatingView.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/04.
//

import UIKit

final class RatingView: UIStackView {
    
    override var intrinsicContentSize: CGSize {
        return .init(width: -1.0, height: config.accessibilityFrame.height)
    }
    
    private var config = UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .largeTitle), scale: .large)
    
    private lazy var starButtons: [UIButton] = {
        var stars = [UIButton(), UIButton(), UIButton(), UIButton(), UIButton()]
        let config = UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .largeTitle), scale: .large)
        stars.forEach {
            $0.setImage(
                UIImage(systemName: "star")?
                    .withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
                    .withConfiguration(config),
                for: .normal
            )
        }
        return stars
    }()
    
    convenience init(config: UIImage.SymbolConfiguration) {
        self.init(frame: .zero)
        self.config = config
        configure()
    }
    
}

private extension RatingView {
    
    func configure() {
        axis = .horizontal
        alignment = .center
        distribution = .fill
        spacing = 9
        addArrangedSubviews(starButtons)
    }
}
