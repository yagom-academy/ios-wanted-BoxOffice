//
//  HeaderView.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/03.
//

import UIKit

final class HeaderView: UICollectionReusableView {
    let sectionHeaderlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sectionHeaderlabel)
        NSLayoutConstraint.activate([
            sectionHeaderlabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10),
            sectionHeaderlabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
