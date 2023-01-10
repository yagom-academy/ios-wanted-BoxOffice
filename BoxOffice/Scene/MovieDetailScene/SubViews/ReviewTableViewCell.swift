//
//  ReviewTableViewCell.swift
//  BoxOffice
//
//  Created by 김주영 on 2023/01/05.
//

import UIKit

final class ReviewTableViewCell: UITableViewCell {
    static let identifier = "ReviewTableViewCell"
    private let nickNameLabel = MovieLabel(font: .headline)
    private let contentLabel = MovieLabel(font: .body)
    private let ratingLabel = MovieLabel(font: .headline)
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle")
        imageView.backgroundColor = .systemGray6
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let starView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .systemYellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let deleteButton: MoviewButton = {
        let button = MoviewButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return button
    }()

    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        stackView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let entireStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    //TODO: MovieDetail로 뷰 세팅하기
    func configure(with review: Review) {
        nickNameLabel.text = review.nickName
        contentLabel.text = review.content
        ratingLabel.text = review.rating
    }
    
    func addTargetDeleteButton(with target: UIViewController, selector: Selector, tag: Int) {
        deleteButton.addTarget(target,
                               action: selector,
                               for: .touchUpInside)
        deleteButton.tag = tag
    }
    
    private func setupView() {
        addSubView()
        setupConstraint()
        contentLabel.numberOfLines = 0
    }
    
    private func addSubView() {
        titleStackView.addArrangedSubview(nickNameLabel)
        titleStackView.addArrangedSubview(starView)
        titleStackView.addArrangedSubview(ratingLabel)
        
        contentStackView.addArrangedSubview(contentLabel)
        contentStackView.addArrangedSubview(deleteButton)
        
        infoStackView.addArrangedSubview(titleStackView)
        infoStackView.addArrangedSubview(contentStackView)
        
        entireStackView.addArrangedSubview(photoImageView)
        entireStackView.addArrangedSubview(infoStackView)
        
        self.contentView.addSubview(entireStackView)
    }
    
    private func setupConstraint() {
        starView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        ratingLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        contentLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        contentLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            entireStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
                                                 constant: 8),
            entireStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                                 constant: -8),
            entireStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            entireStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -8),
            
            photoImageView.widthAnchor.constraint(equalTo: photoImageView.heightAnchor)
        ])
       
    }
}
