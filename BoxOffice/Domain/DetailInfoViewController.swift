//
//  DetailInfoViewController.swift
//  BoxOffice
//
//  Created by Ellen J on 2023/01/04.
//

import UIKit

final class DetailInfoViewController: UIViewController {
    
    private var detailInfoViewModel: DetailInfoViewModel?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    static func instance(_ viewModel: DetailInfoViewModel) -> DetailInfoViewController {
        let viewController = DetailInfoViewController(nibName: nil, bundle: nil)
        viewController.detailInfoViewModel = viewModel
        return viewController
    }
}
