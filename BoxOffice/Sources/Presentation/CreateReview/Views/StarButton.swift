//
//  StarButton.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/06.
//

import UIKit

final class StarButton: UIButton {
    
    private var starState: StarState = .noon
    private lazy var config = UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .largeTitle), scale: .large)
    
    convenience init(config: UIImage.SymbolConfiguration, state: StarState = .noon) {
        self.init(frame: .zero)
        self.starState = state
        self.config = config
        configure()
    }
    
}

private extension StarButton {
    
    func configure() {
        let image = UIImage(systemName: starState.imageName)?
            .withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
            .withConfiguration(config)
        setImage(image, for: .normal)
    }
    
}

extension StarButton {
    
    var currentState: StarState {
        return starState
    }
    
    func changeState(_ state: StarState) {
        self.starState = state
        configure()
    }
    
}

enum StarState {
    case filled
    case leadinghalf
    case noon
    
    var imageName: String {
        switch self {
        case .filled: return "star.fill"
        case .leadinghalf: return "star.leadinghalf.filled"
        case .noon: return "star"
        }
    }
}
