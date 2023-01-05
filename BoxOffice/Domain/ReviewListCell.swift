//
//  ReviewListCell.swift
//  BoxOffice
//
//  Created by 곽우종 on 2023/01/06.
//

import UIKit

protocol ReviewListDelegate: AnyObject {
    func deleteComment(row: Int)
}

final class ReviewListCell: UITableViewCell {
    static let identifier = "\(ReviewListCell.self)"
    
    private enum Constant {
        static var pupleColor = UIColor(r: 76, g: 52, b: 145)
        static var pictureSize: CGFloat = 200
        static var buttonSize: CGFloat = 40
    }
    private var row = 0
    var delegate: ReviewListDelegate?
    
    private lazy var pictureImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = Constant.pupleColor.cgColor
        return imageView
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var nickNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var rateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .yellow
        
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        label.setStarLabel("0.0")
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("삭제", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 20
        return button
    }()
    
     @objc func buttonTapped() {
         delegate?.deleteComment(row: row)
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
        addSubviews(
            pictureImageView,
            labelStackView,
            deleteButton
        )
    }
    
    private func setupUI() {
        // MARK: - posterImageView
        NSLayoutConstraint.activate([
            pictureImageView.topAnchor.constraint(equalTo: topAnchor),
            pictureImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pictureImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            pictureImageView.widthAnchor.constraint(equalToConstant: Constant.pictureSize),
            pictureImageView.heightAnchor.constraint(equalToConstant: Constant.pictureSize)
        ])
        
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: topAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: bottomAnchor),
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
        self.row = row
        pictureImageView.image = model.picture.toUIImage
        nickNameLabel.text = model.nickName
        rateLabel.setStarLabel(String(model.rate))
        infoLabel.text = model.info
    }
}
