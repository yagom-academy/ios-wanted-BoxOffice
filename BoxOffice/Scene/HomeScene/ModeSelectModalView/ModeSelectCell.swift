//
//  ModeSelectCell.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/04.
//

import UIKit

final class ModeSelectCell: UITableViewCell {
    private let boxOfficeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "checkmark")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(label: String, isChecked: Bool) {
        boxOfficeLabel.text = label
        checkImageView.isHidden = !isChecked
    }
}

// MARK: Setup Layout
private extension ModeSelectCell {
    
    func addSubviews() {
        addSubview(boxOfficeLabel)
        addSubview(checkImageView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            boxOfficeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            boxOfficeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            checkImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}
