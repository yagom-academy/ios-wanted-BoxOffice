//
//  BoxOfficeListRankingChangeLabel.swift
//  BoxOffice
//
//  Created by YunYoungseo on 2023/01/03.
//

import UIKit

class BoxOfficeListRankingChangeLabel: UIView {
    var rankingChange: Int = 0 {
        didSet {
            updateLabel(with: rankingChange)
        }
    }
    var font: UIFont = .preferredFont(forTextStyle: .body) {
        didSet {
            label.font = font
        }
    }
    private let label = UILabel()

    init(rankingChange: Int) {
        super.init(frame: .zero)
        self.rankingChange = rankingChange
        addLabel()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addLabel()
    }

    private func addLabel() {
        label.font = font
        updateLabel(with: rankingChange)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalTo: widthAnchor),
            label.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }

    private func updateLabel(with rankingChange: Int) {
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
