//
//  CreateReviewRatingView.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/21.
//

import Foundation
import UIKit
import Combine
import SwiftUI

// MARK: - View
class CreateReviewRatingView: UIView {
    // MARK: View Components
    lazy var circle: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "circle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .appleSDGothicNeo(weight: .bold, size: 14)
        label.textColor = UIColor(hex: "#DFDFDF")
        label.text = "별점"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var ratingView: RatingView = {
        let view = RatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .appleSDGothicNeo(weight: .medium, size: 16)
        label.textColor = UIColor(hex: "#DFDFDF")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Associated Types
    typealias ViewModel = CreateReviewRatingViewModel
    
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
        self.addSubview(circle)
        self.addSubview(titleLabel)
        self.addSubview(ratingView)
        self.addSubview(ratingLabel)
    }
    
    
    // MARK: Layout Views
    func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            circle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            circle.widthAnchor.constraint(equalToConstant: 4),
            circle.heightAnchor.constraint(equalToConstant: 4),
            circle.centerYAnchor.constraint(equalTo: centerYAnchor),
        ]
        
        constraints += [
            titleLabel.leadingAnchor.constraint(equalTo: circle.trailingAnchor, constant: 4),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ]
        
        constraints += [
            ratingView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16),
            ratingView.widthAnchor.constraint(equalToConstant: 100),
            ratingView.heightAnchor.constraint(equalToConstant: 18),
            ratingView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            ratingView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
        ]
        
        constraints += [
            ratingLabel.leadingAnchor.constraint(equalTo: ratingView.trailingAnchor, constant: 12),
            ratingLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ]
    }
    
    
    // MARK: Binding
    func bind(viewModel: ViewModel) {
        viewModel.$ratingViewModel
            .assign(to: \.viewModel, on: ratingView)
            .store(in: &subscriptions)
        
        viewModel.$rating
            .map { "\($0)" }
            .assign(to: \.text, on: ratingLabel)
            .store(in: &subscriptions)
    }
}

#if canImport(SwiftUI) && DEBUG
struct CreateReviewRatingViewPreview: PreviewProvider {
    static var previews: some View {
        ContentViewPreview {
            let view = CreateReviewRatingView()
            view.viewModel = CreateReviewRatingViewModel()
            return view
        }.background(Color(UIColor(hex: "#101010")))
        .previewLayout(.fixed(width: 390, height: 40))
    }
}
#endif
