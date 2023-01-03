//
//  ReviewCell.swift
//  BoxOffice
//
//  Created by 이예은 on 2023/01/03.
//

import UIKit

class ReviewCell: UITableViewCell {
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "circle.fill"))
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return imageView
    }()
    
    private lazy var reviewStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .leading
        stackview.distribution = .equalSpacing
        stackview.spacing = 6
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private lazy var stardeleteStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .fill
        stackview.distribution = .fill
        return stackview
    }()
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        imageView.tintColor = .white
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        return imageView
    }()
    
    private lazy var deleteReviewImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "delete"))
        return imageView
    }()
    
    private lazy var writingLabel: UILabel = {
        let label = UILabel()
        label.text = "씨지가 맞는건지 정말 영상미 최고네용~!!"
        label.textColor = .white
        return label
    }()
    
    private lazy var userInfoStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .leading
        stackview.distribution = .equalSpacing
        stackview.spacing = 6
        return stackview
    }()
    
    private lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "leea**"
        label.textColor = .white
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2023 01.02 17:14"
        label.textColor = .white
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setAutolayout()
        contentView.backgroundColor = UIColor(r: 26, g: 26, b: 26)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAutolayout() {
        contentView.addSubviews(userImageView, reviewStackView)
        
        reviewStackView.addArrangedSubviews(stardeleteStackView, writingLabel, userInfoStackView)
        stardeleteStackView.addArrangedSubviews(starImageView, deleteReviewImageView)
        userInfoStackView.addArrangedSubviews(nicknameLabel, dateLabel)
        
        NSLayoutConstraint.activate([
            userImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            userImageView.bottomAnchor.constraint(equalTo: reviewStackView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            reviewStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            reviewStackView.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 8),
            reviewStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
//            reviewStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
