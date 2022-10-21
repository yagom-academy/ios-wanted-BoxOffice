//
//  MovieDetailNavigationView.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/20.
//

import Foundation
import UIKit
import Combine
import SwiftUI

// MARK: - View
class MovieDetailNavigationView: UIView {
    // MARK: View Components
    var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .appleSDGothicNeo(weight: .bold, size: 16)
        label.textColor = UIColor(hex: "#DFDFDF")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Associated Types
    typealias ViewModel = MovieDetailViewModel
    
    // MARK: Properties
    var didSetupConstraints = false
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel else { return }
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
        self.backgroundColor = UIColor(hex: "#101010")
    }
    
    
    // MARK: Build View Hierarchy
    func buildViewHierarchy() {
        self.addSubview(backButton)
        self.addSubview(titleLabel)
        self.addSubview(shareButton)
    }
    
    
    // MARK: Layout Views
    func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17),
            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 11),
            backButton.heightAnchor.constraint(equalToConstant: 20),
        ]
        
        constraints += [
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ]
        
        constraints += [
            shareButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -23),
            shareButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            shareButton.widthAnchor.constraint(equalToConstant: 15),
            shareButton.heightAnchor.constraint(equalToConstant: 20),
        ]
    }
    
    
    // MARK: Binding
    func bind(viewModel: ViewModel) {
        // Action
        backButton.controlEvent(.touchUpInside)
            .map { ViewModel.ViewAction.dismiss }
            .subscribe(viewModel.viewAction)
            .store(in: &subscriptions)
        
        shareButton.controlEvent(.touchUpInside)
            .map { ViewModel.ViewAction.share }
            .subscribe(viewModel.viewAction)
            .store(in: &subscriptions)
        
        // State
        viewModel.$movie
            .map { $0.movieName }
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: titleLabel)
            .store(in: &subscriptions)
    }
}

#if canImport(SwiftUI) && DEBUG
struct MovieDetailNavigationPreview: PreviewProvider {
    static var previews: some View {
        ContentViewPreview {
            let view = MovieDetailNavigationView()
            view.viewModel = MovieDetailViewModel(movie: Movie.dummyMovie)
            return view
        }.previewLayout(.fixed(width: 390, height: 45))
    }
}
#endif
