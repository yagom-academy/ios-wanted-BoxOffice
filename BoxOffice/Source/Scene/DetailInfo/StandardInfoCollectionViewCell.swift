//
//  StandardInfoCollectionViewCell.swift
//  BoxOffice
//
//  Created by 권준상 on 2022/10/20.
//

import UIKit

final class StandardInfoCollectionViewCell: UICollectionViewCell {
    static let id = "STANDARD"
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        return label
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
        valueLabel.text = ""
    }
    
    func setData(data: StandardMovieInfoEntity) {
        self.titleLabel.text = data.title
        self.valueLabel.text = data.value
    }
    
    private func setLayouts() {
        setProperties()
        setViewHierarchy()
        setConstraints()
    }
    
    private func setProperties() {
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }

    private func setViewHierarchy() {
        contentView.addSubviews(stackView)
        stackView.addArrangedSubviews(
            titleLabel,
            valueLabel)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
    }
}
