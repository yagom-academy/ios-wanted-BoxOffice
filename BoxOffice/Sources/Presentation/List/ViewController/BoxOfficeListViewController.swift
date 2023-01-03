//
//  BoxOfficeListViewController.swift
//  BoxOffice
//
//  Created by Ari on 2022/10/14.
//

import UIKit

class BoxOfficeListViewController: UIViewController {

    weak var coordinator: BoxOfficeListCoordinatorInterface?
    private let viewModel: BoxOfficeListViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemGreen
    }

    init(viewModel: BoxOfficeListViewModel, coordinator: BoxOfficeListCoordinatorInterface) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

