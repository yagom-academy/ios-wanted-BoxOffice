//
//  ReviewTableViewCell.swift
//  BoxOffice
//
//  Created by seohyeon park on 2023/01/05.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let userNicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "별명"
        label.font = .preferredFont(forTextStyle: .callout, compatibleWith: .none)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let starScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "⭐️ 10"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contentTextView: UITextView = {
        let textView = UITextView()
        textView.text = "여기는 리뷰 내용이 들어갑니다!! 재미있게 잘 봤습니다!!"
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let nameAndStarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let userInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let reviewTotalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func setupReivewLabelText(model: LoginModel) {
        
    }
    
    private func configureUI() {
        addSubview(reviewTotalStackView)
        reviewTotalStackView.addArrangedSubview(userInfoStackView)
        reviewTotalStackView.addArrangedSubview(contentTextView)
        userInfoStackView.addArrangedSubview(userImageView)
        userInfoStackView.addArrangedSubview(nameAndStarStackView)
        nameAndStarStackView.addArrangedSubview(userNicknameLabel)
        nameAndStarStackView.addArrangedSubview(starScoreLabel)

        NSLayoutConstraint.activate([
            reviewTotalStackView.topAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.topAnchor
            ),
            reviewTotalStackView.trailingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.trailingAnchor
            ),
            reviewTotalStackView.bottomAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.bottomAnchor
            ),
            reviewTotalStackView.leadingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.leadingAnchor
            )
        ])
    }
}
