//
//  MovieInfoView.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/03.
//

import UIKit

final class MovieInfoView: UIView {
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .lightGray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "내용"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorAsset.detailBackgroundColor
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(name: String, description: String) {
        nameLabel.text = name
        descriptionLabel.text = description
    }

    private func layout() {
        [nameLabel, descriptionLabel].forEach { addSubview($0) }
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),

            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
