//
//  MovieReviewCollectionViewCell.swift
//  BoxOffice
//
//  Created by Judy on 2023/01/05.
//

import UIKit

final class MovieReviewView: UIView {
    private let reviewTitleLabel = MovieLabel(font: .title3, isBold: true)
    private let reviewTableView: UITableView
    
    private let writeReviewButton: MoviewButton = {
        let button = MoviewButton(title: "리뷰 작성하기")
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return button
    }()
    
    private let moreReviewButton: MoviewButton = {
        let button = MoviewButton(title: "더보기")
        button.layer.borderColor = UIColor.systemGray5.cgColor
        button.layer.borderWidth = 2
        return button
    }()
    
    private let entireStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let reviewTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(tableView: UITableView, frame: CGRect = .zero) {
        reviewTableView = tableView
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTargetWriteButton(with target: UIViewController, selector: Selector) {
        writeReviewButton.addTarget(target,
                                    action: selector,
                                    for: .touchUpInside)
    }
    
    func addTargetMoreButton(with target: UIViewController, selector: Selector) {
        moreReviewButton.addTarget(target,
                                   action: selector,
                                   for: .touchUpInside)
    }
    
    func moreButtonState(isEnabled: Bool) {
        moreReviewButton.isEnabled = isEnabled
    }
    
    private func setupView() {
        addSubView()
        setupConstraint()
        reviewTitleLabel.text = "리뷰"
    }
    
    private func addSubView() {
        reviewTitleStackView.addArrangedSubview(reviewTitleLabel)
        reviewTitleStackView.addArrangedSubview(writeReviewButton)
        
        entireStackView.addArrangedSubview(reviewTitleStackView)
        entireStackView.addArrangedSubview(reviewTableView)
        entireStackView.addArrangedSubview(moreReviewButton)
        
        self.addSubview(entireStackView)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            entireStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
                                                 constant: 8),
            entireStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                                 constant: -8),
            entireStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                                 constant: 16),
            entireStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -16)
        ])
    }
}
