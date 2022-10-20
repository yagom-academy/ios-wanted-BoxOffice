//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/20.
//

import Foundation
import UIKit

// MARK: - View Controller
class MovieDetailViewController: UIViewController {
    // MARK: View Components
    
    
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
        
    }
    
    // MARK: Build View Hierarchy
    func buildViewHierarchy() {
        
    }
    
    // MARK: Layout Views
    func setupConstraints() {
        
    }
    
    
    // MARK: Binding
    func bind(viewModel: ViewModel) {
        
    }
}
