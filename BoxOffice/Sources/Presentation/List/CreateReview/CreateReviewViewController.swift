//
//  CreateReviewViewController.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/04.
//

import UIKit

class CreateReviewViewController: UIViewController {

    weak var coordinator: BoxOfficeListCoordinatorInterface?
    private let viewModel: CreateReviewViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    init(viewModel: CreateReviewViewModel, coordinator: BoxOfficeListCoordinatorInterface) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension CreateReviewViewController {
    
    func setUp() {
        setUpNavigationBar()
        setUpView()
    }
    
    func setUpNavigationBar() {
        navigationItem.title = "리뷰쓰기"
    }
    
    func setUpView() {
        view.backgroundColor = .boBackground
    }
    
}
