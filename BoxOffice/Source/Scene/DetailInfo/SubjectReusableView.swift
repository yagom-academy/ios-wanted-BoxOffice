//
//  SubjectReusableView.swift
//  BoxOffice
//
//  Created by 권준상 on 2022/10/20.
//

import UIKit

final class SubjectReusableView: UICollectionReusableView {
    static let id = "HEADER"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
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
    }
    
    public func setData(title: String) {
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
        self.addSubviews(titleLabel)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
        
    }
}
