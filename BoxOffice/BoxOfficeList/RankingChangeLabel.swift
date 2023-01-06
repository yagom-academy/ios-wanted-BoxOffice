//
//  RankingChangeLabel.swift
//  BoxOffice
//
//  Created by YunYoungseo on 2023/01/03.
//

import UIKit

class RankingChangeLabel: UIView {
    private let label = UILabel()
    var rankingChange: RankingChange {
        didSet {
            updateLabel(with: rankingChange)
        }
    }

    var font: UIFont {
        get {
            label.font
        }
        set {
            label.font = newValue
        }
    }

    init(rankingChange: RankingChange = .old(change: 0)) {
        self.rankingChange = rankingChange
        super.init(frame: .zero)
        addLabel()
    }

    required init?(coder: NSCoder) {
        self.rankingChange = .old(change: 0)
        super.init(coder: coder)
        addLabel()
    }

    private func addLabel() {
        updateLabel(with: rankingChange)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func updateLabel(with rankingChange: RankingChange) {
        switch rankingChange {
        case .new:
            label.text = "New"
            label.textColor = .systemRed
        case .old(let change):
            updateOld(rankingChange: change)
        }

        func updateOld(rankingChange: Int) {
            if rankingChange == 0 {
                label.text = ""
            } else if rankingChange > 0 {
                label.text = "↑\(abs(rankingChange))"
                label.textColor = .systemRed
            } else {
                label.text = "↓\(abs(rankingChange))"
                label.textColor = .systemGreen
            }
        }
    }
}

extension RankingChangeLabel {
    enum RankingChange {
        case new
        case old(change: Int)
    }
}
