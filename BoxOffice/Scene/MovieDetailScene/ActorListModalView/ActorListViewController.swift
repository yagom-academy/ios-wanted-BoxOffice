//
//  ActorListViewController.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/06.
//

import UIKit

final class ActorListViewController: UIViewController {
    private let mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let actorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let customTransitioningDelegate = ActorListTransitioningDelegate()
    private let navigationBar = UINavigationBar(frame: .zero)
    private let actorList: [String]
    
    init(actorList: [String]) {
        self.actorList = actorList
        super.init(nibName: nil, bundle: nil)
        setupModalStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        setupNavigationBar()
        addSubviews()
        setLayout()
        addActor()
    }
    
    private func setupModalStyle() {
        modalPresentationStyle = .custom
        modalTransitionStyle = .flipHorizontal
        transitioningDelegate = customTransitioningDelegate
    }
    
    private func setupInitialView() {
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
    }
    
    private func setupNavigationBar() {
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.isTranslucent = false
        navigationBar.backgroundColor = .systemBackground
        let naviItem = UINavigationItem(title: "출연진 정보")
        navigationBar.items = [naviItem]
    }
    
    private func addActor() {
        for actor in actorList {
            let actorNameLabel = MovieLabel(font: .title3)
            actorNameLabel.textColor = .label
            actorNameLabel.text = actor
            actorStackView.addArrangedSubview(actorNameLabel)
        }
    }
}

private extension ActorListViewController {
    
    func addSubviews() {
        view.addSubview(navigationBar)
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(actorStackView)
    }
    
    func setLayout() {
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 50),
            
            mainScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            mainScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            actorStackView.topAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.topAnchor),
            actorStackView.bottomAnchor.constraint(lessThanOrEqualTo: mainScrollView.contentLayoutGuide.bottomAnchor),
            actorStackView.leadingAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.leadingAnchor),
            actorStackView.trailingAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.trailingAnchor),
            actorStackView.widthAnchor.constraint(equalTo: mainScrollView.frameLayoutGuide.widthAnchor)
        ])
    }
}
