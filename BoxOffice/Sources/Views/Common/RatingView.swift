//
//  RatingView.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/21.
//

import Foundation
import UIKit
import Combine
import SwiftUI

// MARK: - View
class RatingView: UIView {
    // MARK: View Components
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    lazy var stars: [UIImageView] = {
        var stars = [UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView()]
        stars.forEach {
            $0.image = UIImage(named: "emptyStar")
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return stars
    }()
    
    // MARK: Associated Types
    typealias ViewModel = RatingViewModel
    
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
        self.addSubview(stackView)
        stars.forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    
    // MARK: Layout Views
    func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
    }
    
    
    // MARK: Binding
    func bind(viewModel: ViewModel) {
        stackView.gesture(.tap)
            .merge(with: stackView.gesture(.pan))
            .compactMap { [weak self] gesture in
                guard let self else { return nil }
                let x = gesture.location(in: self.stackView).x
                var rating = Int(round((x / self.stackView.bounds.width) * 10))
                rating = min(10, max(0, rating))
                return rating
            }.assign(to: \.rating, on: viewModel)
            .store(in: &subscriptions)
        
        viewModel.$rating
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] rating in
                guard let self else { return }
                self.stars.enumerated().forEach { index, star in
                    if rating - index * 2 <= 0 {
                        star.image = UIImage(named: "emptyStar")
                    } else if rating - index * 2 == 1 {
                        star.image = UIImage(named: "halfStar")
                    } else {
                        star.image = UIImage(named: "fullStar")
                    }
                }
            }).store(in: &subscriptions)
    }
}

#if canImport(SwiftUI) && DEBUG
struct RatingViewPreview: PreviewProvider {
    static var previews: some View {
        ContentViewPreview {
            let view = RatingView()
            view.viewModel = RatingViewModel()
            view.viewModel?.rating = 5
            return view
        }.background(Color(UIColor(hex: "#101010")))
            .previewLayout(.fixed(width: 200, height: 36))
    }
}
#endif
