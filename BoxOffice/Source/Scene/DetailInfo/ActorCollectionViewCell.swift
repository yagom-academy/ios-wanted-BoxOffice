//
//  ActorCollectionViewCell.swift
//  BoxOffice
//
//  Created by 권준상 on 2022/10/20.
//

import UIKit

final class ActorCollectionViewCell: UICollectionViewCell {
    static let id = "ACTOR"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .systemGray
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayouts()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
    }
    
    func setData(title: String) {
        self.titleLabel.text = title
    }
    
    
    private func setLayouts() {
        setProperties()
        setViewHierarchy()
        setConstraints()
    }
    
    private func setProperties() {
        self.backgroundColor = .systemBackground
    }

    private func setViewHierarchy() {
        contentView.addSubviews(titleLabel, nextButton)
    }

    private func setConstraints() {
        [titleLabel, nextButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            nextButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nextButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            nextButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
