//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/20.
//

import Foundation
import UIKit
import Combine
import SwiftUI

// MARK: - View Controller
class MovieDetailViewController: UIViewController {
    // MARK: View Components
    lazy var navigationView: MovieDetailNavigationView = {
        let view = MovieDetailNavigationView()
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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var posterView: MoviePosterView = {
        let view = MoviePosterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var detailInfoView: MovieDetailInfoView = {
        let view = MovieDetailInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        contentView.addSubview(posterView)
        contentView.addSubview(detailInfoView)
    }
    
    // MARK: Layout Views
    func setupConstraints() {
        var constraint = [NSLayoutConstraint]()
        
        defer { NSLayoutConstraint.activate(constraint) }
        
        constraint += [
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: 45),
        ]
        
        constraint += [
            scrollView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        constraint += [
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 2000),
        ]
        
        constraint += [
            posterView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            posterView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            posterView.widthAnchor.constraint(equalToConstant: 172),
            posterView.heightAnchor.constraint(equalToConstant: 236),
        ]
        
        constraint += [
            detailInfoView.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 32),
            detailInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            detailInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            detailInfoView.heightAnchor.constraint(equalToConstant: 150),
        ]
    }
    
    
    // MARK: Binding
    func bind(viewModel: ViewModel) {
        viewModel.$posterModel
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] viewModel in
                guard let self else { return }
                self.posterView.viewModel = viewModel
            }).store(in: &subscriptions)
        
        navigationView.viewModel = viewModel
        detailInfoView.viewModel = viewModel
    }
}

#if canImport(SwiftUI) && DEBUG
struct MovieDetailViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ContentViewControllerPreview {
            let vc = MovieDetailViewController()
            vc.viewModel = MovieDetailViewModel(movie: .dummyMovie)
            return vc
        }
    }
}
#endif

