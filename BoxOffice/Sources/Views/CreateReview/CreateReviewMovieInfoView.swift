//
//  CreateReviewMovieInfoView.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/21.
//

import Foundation
import UIKit
import Combine
import SwiftUI

// MARK: - View
class CreateReviewMovieInfoView: UIView {
    // MARK: View Components
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(hex: "#D9D9D9")
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .appleSDGothicNeo(weight: .bold, size: 14)
        label.textColor = UIColor(hex: "#DFDFDF")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Associated Types
    typealias ViewModel = CreateReviewViewModel
    
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
        self.addSubview(imageView)
        self.addSubview(titleLabel)
    }
    
    
    // MARK: Layout Views
    func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 21),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            imageView.widthAnchor.constraint(equalToConstant: 68),
            imageView.heightAnchor.constraint(equalToConstant: 93),
        ]
        
        constraints += [
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 29),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ]
    }
    
    
    // MARK: Binding
    func bind(viewModel: ViewModel) {
        viewModel.$posterImage
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: imageView)
            .store(in: &subscriptions)
        
        viewModel.$movie
            .map { $0.movieName }
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: titleLabel)
            .store(in: &subscriptions)
    }
}

#if canImport(SwiftUI) && DEBUG
struct CreateReviewMovieInfoViewPreview: PreviewProvider {
    static var previews: some View {
        ContentViewPreview {
            let view = CreateReviewMovieInfoView()
            view.viewModel = CreateReviewViewModel(movie: .dummyMovie)
            return view
        }.background(Color(UIColor(hex: "#101010")))
        .previewLayout(.fixed(width: 390, height: 138))
    }
}
#endif
