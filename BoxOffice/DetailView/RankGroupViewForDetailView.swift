//
//  RankGroupViewForDetailView.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/18.
//

import UIKit

class RankGroupViewForDetailView : RankGroupView {
    lazy var setStackViewH : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [rankDiffImage,rankDiffLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 2
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    lazy var newStackViewH : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [setStackViewH,rankLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    lazy var newStackViewV : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [newLabel,newStackViewH])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    override func setConstraints() {
        NSLayoutConstraint.activate([
            newStackViewV.topAnchor.constraint(equalTo: self.topAnchor),
            newStackViewV.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            newStackViewV.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            newStackViewV.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    override func addSubViews() {
        self.addSubview(newStackViewV)
    }
}
