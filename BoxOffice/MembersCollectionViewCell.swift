//
//  MembersCollectionViewCell.swift
//  BoxOffice
//
//  Created by seohyeon park on 2023/01/02.
//

import UIKit

class MembersCollectionViewCell: UICollectionViewCell {
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름이름이름이름"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let roleLabel: UILabel = {
        let label = UILabel()
        label.text = "배역"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(totalStackView)
        totalStackView.addArrangedSubview(nameLabel)
        totalStackView.addArrangedSubview(roleLabel)

        NSLayoutConstraint.activate([
            totalStackView.topAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.topAnchor
            ),
            totalStackView.trailingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.trailingAnchor
            ),
            totalStackView.bottomAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.bottomAnchor
            ),
            totalStackView.leadingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.leadingAnchor
            )
        ])
    }
}
