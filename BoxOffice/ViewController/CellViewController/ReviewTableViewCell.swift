//
//  ReviewTableViewCell.swift
//  BoxOffice
//
//  Created by 천승희 on 2023/01/06.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    static let identify = "Cell"
    static var end: Int?
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let rateLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let rateStackView: UIStackView = {
        var buttons: [UIButton] = []
        lazy var stackView = UIStackView()
        guard let end = ReviewTableViewCell.end else {
            return UIStackView()
        }
        
        for i in 0..<end {
            lazy var button = UIButton()
            button.setImage(UIImage(systemName: "star.fill"), for: .normal)
            buttons += [button]
            stackView.addArrangedSubview(button)
        }
        for i in end..<5 {
            lazy var button = UIButton()
            button.setImage(UIImage(systemName: "star"), for: .normal)
            buttons += [button]
            stackView.addArrangedSubview(button)
        }
        
        return stackView
    }()
    
    let reviewImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func layout() {
        [nicknameLabel, rateLabel, rateStackView, contentLabel, reviewImageView].forEach {
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            rateStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            rateStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            
            rateLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            rateLabel.leadingAnchor.constraint(equalTo: rateStackView.trailingAnchor, constant: 5),
            
            contentLabel.topAnchor.constraint(equalTo: rateStackView.bottomAnchor, constant: 5),
            contentLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            
            nicknameLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 5),
            nicknameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            
            reviewImageView.heightAnchor.constraint(equalToConstant: 80),
            reviewImageView.widthAnchor.constraint(equalToConstant: 100),
            reviewImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            reviewImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
        ])
    }
}
