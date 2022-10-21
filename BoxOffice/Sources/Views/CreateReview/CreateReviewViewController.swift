//
//  CreateReviewViewController.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/21.
//

import Foundation
import UIKit
import Combine
import SwiftUI

// MARK: - View Controller
class CreateReviewViewController: UIViewController {
    // MARK: View Components
    lazy var navigationView: CreateReviewNavigationView = {
        let view = CreateReviewNavigationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var infoView: CreateReviewMovieInfoView = {
        let view = CreateReviewMovieInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var ratingView: CreateReviewRatingView = {
        let view = CreateReviewRatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nicknameView: CreateReviewNicknameView = {
        let view = CreateReviewNicknameView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dividerViews: [UIView] = {
        var views = [UIView(), UIView(), UIView(), UIView(), UIView()]
        views.forEach {
            $0.backgroundColor = UIColor(hex: "#707070").withAlphaComponent(0.6)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return views
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
    
    
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        buildViewHierarchy()
        self.view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            self.setupConstraints()
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    
    // MARK: Setup Views
    func setupViews() {
        self.view.backgroundColor = UIColor(hex: "#101010")
    }
    
    // MARK: Build View Hierarchy
    func buildViewHierarchy() {
        self.view.addSubview(navigationView)
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(infoView)
        contentView.addSubview(ratingView)
        contentView.addSubview(nicknameView)
        dividerViews.forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: Layout Views
    func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: 45),
        ]
        
        constraints += [
            scrollView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        
        constraints += [
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 2000),
        ]
        
        constraints += [
            infoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            infoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ]
        
        constraints += [
            dividerViews[0].topAnchor.constraint(equalTo: infoView.bottomAnchor),
            dividerViews[0].leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dividerViews[0].trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dividerViews[0].heightAnchor.constraint(equalToConstant: 1),
        ]
        
        constraints += [
            ratingView.topAnchor.constraint(equalTo: dividerViews[0].bottomAnchor),
            ratingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ratingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ]
        
        constraints += [
            dividerViews[1].topAnchor.constraint(equalTo: ratingView.bottomAnchor),
            dividerViews[1].leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dividerViews[1].trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dividerViews[1].heightAnchor.constraint(equalToConstant: 1),
        ]
        
        constraints += [
            nicknameView.topAnchor.constraint(equalTo: dividerViews[1].bottomAnchor),
            nicknameView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nicknameView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ]
        
        constraints += [
            dividerViews[2].topAnchor.constraint(equalTo: nicknameView.bottomAnchor),
            dividerViews[2].leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dividerViews[2].trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dividerViews[2].heightAnchor.constraint(equalToConstant: 1),
        ]
    }
    
    
    // MARK: Binding
    func bind(viewModel: ViewModel) {
        navigationView.viewModel = viewModel
        infoView.viewModel = viewModel
        nicknameView.viewModel = viewModel
    }
    
    // MARK: Util
    func getDividerView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#707070").withAlphaComponent(0.6)
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

#if canImport(SwiftUI) && DEBUG
struct CreateReviewViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ContentViewControllerPreview {
            let vc = CreateReviewViewController()
            vc.viewModel = CreateReviewViewModel(movie: .dummyMovie)
            return vc
        }
    }
}
#endif

