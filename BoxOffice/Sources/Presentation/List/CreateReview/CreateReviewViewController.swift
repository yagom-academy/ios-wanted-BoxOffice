//
//  CreateReviewViewController.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/04.
//

import UIKit

class CreateReviewViewController: UIViewController {

    weak var coordinator: CreateReviewCoordinatorInterface?
    private let viewModel: CreateReviewViewModel
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let config = UIImage.SymbolConfiguration(textStyle: .callout, scale: .large)
        button.setImage(UIImage(systemName: "xmark")?.withConfiguration(config), for: .normal)
        button.addTarget(self, action: #selector(didTapCancelButton(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    init(viewModel: CreateReviewViewModel, coordinator: CreateReviewCoordinatorInterface) {
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelButton)
    }
    
    func setUpView() {
        view.backgroundColor = .boBackground
    }
    
    @objc func didTapCancelButton(_ sender: UIButton) {
        dismiss(animated: true) { [weak self] in
            self?.coordinator?.finish()
        }
    }
    
}
