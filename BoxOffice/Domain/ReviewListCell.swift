//
//  ReviewListCell.swift
//  BoxOffice
//
//  Created by 곽우종 on 2023/01/06.
//

import UIKit

protocol ReviewListDelegate: AnyObject {
    func deleteComment(comment: Comment)
}

final class ReviewListCell: UITableViewCell {
    static let identifier = "\(ReviewListCell.self)"
    
    private enum Constant {
        static var pupleColor = UIColor(r: 76, g: 52, b: 145)
        static var pictureSize: CGFloat = 100
        static var buttonSize: CGFloat = 60
    }
    private var comment: Comment?
    var delegate: ReviewListDelegate?
    
    private lazy var pictureImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = Constant.pupleColor.cgColor
        return imageView
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var nickNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    private lazy var rateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .systemYellow
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .left
        label.setStarLabel("0.0")
        label.sizeToFit()
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = Constant.pupleColor
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.becomeFirstResponder()
        return button
    }()
    
     @objc func buttonTapped() {
         guard let comment = comment else { return }
         delegate?.deleteComment(comment: comment)
     }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.masksToBounds = true
        
        labelStackView.addArrangedSubviews(
            nickNameLabel,
            rateLabel,
            infoLabel
        )
        contentView.addSubviews(
            pictureImageView,
            labelStackView,
            deleteButton
        )
    }
    
    private func setupUI() {
        
        NSLayoutConstraint.activate([
            pictureImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            pictureImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            pictureImageView.widthAnchor.constraint(equalToConstant: Constant.pictureSize),
            pictureImageView.heightAnchor.constraint(equalToConstant: Constant.pictureSize)
        ])
        
        NSLayoutConstraint.activate([
            nickNameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            rateLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
        ])
        
        NSLayoutConstraint.activate([
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: Constant.buttonSize),
            deleteButton.heightAnchor.constraint(equalToConstant: Constant.buttonSize)
        ])
        
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: topAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor),
            labelStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: pictureImageView.trailingAnchor)
        ])
    }
    
    func configureCell(_ model: Comment, row: Int) {
        self.comment = model
        pictureImageView.image = model.picture.toUIImage
        nickNameLabel.text = "아이디: " + model.nickName
        rateLabel.setStarLabel(String(model.rate))
        infoLabel.text = model.info
    }
}
