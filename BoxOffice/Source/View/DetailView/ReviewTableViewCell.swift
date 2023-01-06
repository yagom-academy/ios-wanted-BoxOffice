//
//  ReviewTableViewCell.swift
//  BoxOffice
//
//  Created by seohyeon park on 2023/01/05.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    // MARK: properties
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let userNicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let starScoreLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 10
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameAndStarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let userInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let reviewTotalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: private function
    private func configureUI() {
        addSubview(reviewTotalStackView)
        reviewTotalStackView.addArrangedSubview(userInfoStackView)
        reviewTotalStackView.addArrangedSubview(contentLabel)
        
        userInfoStackView.addArrangedSubview(userImageView)
        userInfoStackView.addArrangedSubview(nameAndStarStackView)
        
        nameAndStarStackView.addArrangedSubview(userNicknameLabel)
        nameAndStarStackView.addArrangedSubview(starScoreLabel)

        NSLayoutConstraint.activate([
            reviewTotalStackView.topAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.topAnchor,
                constant: 10
            ),
            reviewTotalStackView.trailingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                constant: -10
            ),
            reviewTotalStackView.bottomAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.bottomAnchor,
                constant: -10
            ),
            reviewTotalStackView.leadingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                constant: 10
            ),
            
            userImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: function
    func setupReviewLabelText(model: LoginModel) {
        if let image = model.image.imageFromBase64 {
            userImageView.image = image
        }

        userNicknameLabel.text = model.nickname
        starScoreLabel.text = "⭐️ \(String(model.star))점"
        contentLabel.text = model.content
    }
}
