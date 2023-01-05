//
//  ReviewListViewController.swift
//  BoxOffice
//
//  Created by Ellen J on 2023/01/04.
//

import UIKit

final class ReviewListViewController: UIViewController {
    
    private var reviewListViewModel: ReviewListViewModel?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    static func instance(_ viewModel: ReviewListViewModel) -> ReviewListViewController {
        let viewController = ReviewListViewController(nibName: nil, bundle: nil)
        viewController.reviewListViewModel = viewModel
        return viewController
    }
}
