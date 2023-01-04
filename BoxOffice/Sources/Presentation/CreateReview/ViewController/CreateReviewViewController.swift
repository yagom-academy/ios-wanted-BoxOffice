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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubviews(backgroundStackView)
        return scrollView
    }()
    
    private lazy var backgroundStackView: UIStackView = {
        let stackView = UIStackView(axis: .vertical, alignment: .center, distribution: .fill, spacing: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20)
        stackView.addArrangedSubviews(createImageButton, ratingView)
        return stackView
    }()
    
    
    private lazy var createImageButton: ProfileImageButton = {
        let button = ProfileImageButton(size: 125)
        return button
    }()
    
    private lazy var ratingView: RatingView = {
        let view = RatingView(
            config: UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .largeTitle), scale: .large)
        )
        return view
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
        view.addSubviews(scrollView)
        let height = backgroundStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        height.priority = .defaultLow
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            backgroundStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            backgroundStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            backgroundStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            backgroundStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            height
        ])
    }
    
    @objc func didTapCancelButton(_ sender: UIButton) {
        dismiss(animated: true) { [weak self] in
            self?.coordinator?.finish()
        }
    }
    
}
