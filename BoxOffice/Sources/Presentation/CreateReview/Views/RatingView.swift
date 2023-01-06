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
        var stars = [
            StarButton(config: config),
            StarButton(config: config),
            StarButton(config: config),
            StarButton(config: config),
            StarButton(config: config)
        ]
        stars.enumerated().forEach { (index, button) in
            button.tag = index
        }
        return stars
    }()
    
    convenience init(config: UIImage.SymbolConfiguration) {
        self.init(frame: .zero)
        self.config = config
        configure()
    }
    
    func addTarget(target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        starButtons.forEach { button in
            button.addTarget(target, action: action, for: controlEvents)
        }
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
