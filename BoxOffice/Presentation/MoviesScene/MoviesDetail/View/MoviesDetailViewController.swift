//
//  MoviesDetailViewController.swift
//  BoxOffice
//
//  Created by channy on 2022/10/22.
//

import UIKit

class MoviesDetailViewController: UIViewController {
    
    var viewModel: MoviesDetailItemViewModel?
    var repository: MoviesRepository?
    
    init(viewModel: MoviesDetailItemViewModel, repository: MoviesRepository) {
        self.viewModel = viewModel
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMovie()
        setupViews()
        setupConstraints()
        bind()
        setNavigationbar()
    }
    
}

extension MoviesDetailViewController {
    
    func fetchMovie() {
        
    }
    
    func setupViews() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func bind() {
        
    }
    
    func setNavigationbar() {
        
    }
}
