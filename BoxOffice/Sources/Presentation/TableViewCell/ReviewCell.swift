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
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
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
    private lazy var starsStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.distribution = .equalSpacing
        stackview.spacing = 4
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private lazy var firstStarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        imageView.tintColor = .white
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.tintColor = UIColor(r: 246, g: 201, b: 68)
        return imageView
    }()
    
    private lazy var secondStarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        imageView.tintColor = .white
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.tintColor = UIColor(r: 246, g: 201, b: 68)
        return imageView
    }()
    
    private lazy var thirdStarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        imageView.tintColor = .white
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.tintColor = UIColor(r: 246, g: 201, b: 68)
        return imageView
    }()
    
    private lazy var fourthStarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        imageView.tintColor = .white
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.tintColor = UIColor(r: 246, g: 201, b: 68)
        return imageView
    }()
    
    private lazy var fifthStarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        imageView.tintColor = .white
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.tintColor = .clear
        return imageView
    }()
    
    lazy var deleteButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = UIColor(r: 100, g: 100, b: 100)
        return button
    }()
    
    private lazy var writingLabel: UILabel = {
        let label = UILabel()
        label.text = "씨지가 맞는건지 정말 영상미 최고네용~!!"
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.font = .preferredFont(forTextStyle: .subheadline)
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
        label.font = .preferredFont(forTextStyle: .caption2)
        label.textColor = .white
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2023 01.02 17:14"
        label.font = .preferredFont(forTextStyle: .caption2)
        label.textColor = .white
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setAutolayout()
        contentView.backgroundColor = .boBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAutolayout() {
        contentView.addSubviews(userImageView, reviewStackView, deleteButton)
        
        reviewStackView.addArrangedSubviews(starsStackView, writingLabel, userInfoStackView)
        userInfoStackView.addArrangedSubviews(nicknameLabel, dateLabel)
        starsStackView.addArrangedSubviews(firstStarImageView, secondStarImageView, thirdStarImageView, fourthStarImageView, fifthStarImageView)
        
        NSLayoutConstraint.activate([
            userImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            reviewStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            reviewStackView.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 8),
            reviewStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            deleteButton.leadingAnchor.constraint(equalTo: reviewStackView.trailingAnchor, constant: 8),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            deleteButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func transferData(_ reviews: [Review], _ index: Int) {
        guard reviews.indices.contains(index) else {
            return
        }
        userImageView.image = reviews[index].userImage.toUIImage()
        // star..
        writingLabel.text = reviews[index].review
        nicknameLabel.text = reviews[index].nickname
        dateLabel.text = reviews[index].date?.toString(DateFormat(rawValue: "yyyy.mm.dd")!)
    }
}
