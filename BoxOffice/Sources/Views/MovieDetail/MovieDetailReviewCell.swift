//
//  MovieDetailReviewCell.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/22.
//

import Foundation
import UIKit
import Combine
import SwiftUI

// MARK: - View
class MovieDetailReviewCell: UIView {
    // MARK: View Components
    lazy var ratingView: RatingView = {
        let view = RatingView()
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .appleSDGothicNeo(weight: .medium, size: 14)
        label.textColor = UIColor(hex: "#DFDFDF")
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .appleSDGothicNeo(weight: .regular, size: 12)
        label.textColor = UIColor(hex: "#DFDFDF")
        label.numberOfLines = 0
        #if DEBUG
        label.text = "리뷰 내용이 여기에 들어갑니다. 리뷰 내용은 여기에 들어가요. 리뷰 내용은 여기 들어갑니다. 리뷰 내용이 여기에 들어가요. 리뷰 내용은 여기에 들어가요. 리뷰 내용은 여기 들어간다구요."
        #endif
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(hex: "#D9D9D9")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .appleSDGothicNeo(weight: .medium, size: 12)
        label.textColor = UIColor(hex: "#848484")
        #if DEBUG
        label.text = "별명이 들어갑니다"
        #endif
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor(hex: "#707070").cgColor
        button.layer.borderWidth = 1
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = UIColor(hex: "#DFDFDF")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Associated Types
    typealias ViewModel = MovieDetailReviewCellModel
    
    // MARK: Properties
    var didSetupConstraints = false
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            bind(viewModel: viewModel)
        }
    }
    var subscriptions = [AnyCancellable]()
    
    // MARK: Life Cycle
    init() {
        super.init(frame: .zero)
        setupViews()
        buildViewHierarchy()
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            self.setupConstraints()
            didSetupConstraints = true
        }
        super.updateConstraints()
    }
    
    // MARK: Setup Views
    func setupViews() {
        self.backgroundColor = .clear
    }
    
    
    // MARK: Build View Hierarchy
    func buildViewHierarchy() {
        self.addSubview(ratingView)
        self.addSubview(ratingLabel)
        self.addSubview(contentLabel)
        self.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        self.addSubview(nicknameLabel)
        self.addSubview(deleteButton)
    }
    
    
    // MARK: Layout Views
    func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            ratingView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            ratingView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            ratingView.widthAnchor.constraint(equalToConstant: 100),
            ratingView.heightAnchor.constraint(equalToConstant: 18),
        ]
        
        constraints += [
            ratingLabel.leadingAnchor.constraint(equalTo: ratingView.trailingAnchor, constant: 6),
            ratingLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor),
        ]
        
        constraints += [
            contentLabel.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 8),
            contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
        ]
        
        constraints += [
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: contentLabel.trailingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120),
        ]
        
        constraints += [
            nicknameLabel.topAnchor.constraint(greaterThanOrEqualTo: contentLabel.bottomAnchor, constant: 18),
            nicknameLabel.topAnchor.constraint(greaterThanOrEqualTo: stackView.bottomAnchor, constant: 18),
            nicknameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            nicknameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
        ]
        
        constraints += [
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28),
            deleteButton.centerYAnchor.constraint(equalTo: nicknameLabel.centerYAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 24),
            deleteButton.heightAnchor.constraint(equalToConstant: 24),
        ]
    }
    
    
    // MARK: Binding
    func bind(viewModel: ViewModel) {
        viewModel.$ratingViewModel
            .assign(to: \.viewModel, on: ratingView)
            .store(in: &subscriptions)
        
        viewModel.$review
            .map { "\($0.rating)" }
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: ratingLabel)
            .store(in: &subscriptions)
        
        viewModel.$review
            .map { $0.photo }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] imageData in
                guard let self else { return }
                if let imageData,
                   let image = UIImage(data: imageData) {
                    self.imageView.image = image
                    self.imageView.isHidden = false
                } else {
                    self.imageView.isHidden = true
                }
            }).store(in: &subscriptions)
        
        viewModel.$review
            .map { $0.content }
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: contentLabel)
            .store(in: &subscriptions)
        
        viewModel.$review
            .map { $0.nickname }
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: nicknameLabel)
            .store(in: &subscriptions)
    }
}

#if canImport(SwiftUI) && DEBUG
struct MovieDetailReviewCellPreview: PreviewProvider {
    static var previews: some View {
        ContentViewPreview {
            let view = MovieDetailReviewCell()
            view.viewModel = MovieDetailReviewCellModel(review: .dummyReview)
            return view
        }.background(Color(UIColor(hex: "#101010")))
        .previewLayout(.sizeThatFits)
    }
}
#endif
