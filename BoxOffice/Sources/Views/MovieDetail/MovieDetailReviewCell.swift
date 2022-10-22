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
class MovieDetailReviewCell: UITableViewCell {
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
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var photoView: UIImageView = {
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
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
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
            layoutIfNeeded()
        }
    }
    var subscriptions = [AnyCancellable]()
    
    // MARK: Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        subscriptions = []
//        ratingView.viewModel = nil
//        ratingLabel.text = nil
//        contentLabel.text = nil
//        photoView.image = nil
//        photoView.isHidden = true
//        nicknameLabel.text = nil
    }
    
    // MARK: Setup Views
    func setupViews() {
        self.backgroundColor = .clear
    }
    
    
    // MARK: Build View Hierarchy
    func buildViewHierarchy() {
        self.contentView.addSubview(ratingView)
        self.contentView.addSubview(ratingLabel)
        self.contentView.addSubview(contentLabel)
        self.contentView.addSubview(stackView)
        stackView.addArrangedSubview(photoView)
        self.contentView.addSubview(nicknameLabel)
        self.contentView.addSubview(deleteButton)
    }
    
    
    // MARK: Layout Views
    func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            ratingView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            ratingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28),
            ratingView.widthAnchor.constraint(equalToConstant: 100),
            ratingView.heightAnchor.constraint(equalToConstant: 18),
        ]
        
        constraints += [
            ratingLabel.leadingAnchor.constraint(equalTo: ratingView.trailingAnchor, constant: 6),
            ratingLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor),
        ]
        
        constraints += [
            contentLabel.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 8),
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28),
        ]
        
        constraints += [
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: contentLabel.trailingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -28),
            photoView.widthAnchor.constraint(equalToConstant: 120),
            photoView.heightAnchor.constraint(equalToConstant: 120),
        ]
        
        let spacingConstraints = [
            nicknameLabel.topAnchor.constraint(greaterThanOrEqualTo: contentLabel.bottomAnchor, constant: 18),
            nicknameLabel.topAnchor.constraint(greaterThanOrEqualTo: stackView.bottomAnchor, constant: 18),
        ]
        
        spacingConstraints.forEach {
            $0.priority = .defaultLow
        }
        
        constraints += spacingConstraints
        
        constraints += [
            nicknameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28),
            nicknameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ]
        
        constraints += [
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -28),
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
                    self.photoView.image = image
                    self.photoView.isHidden = false
                } else {
                    self.photoView.isHidden = true
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
        .previewLayout(.fixed(width: 2000, height: 500))
    }
}
#endif
