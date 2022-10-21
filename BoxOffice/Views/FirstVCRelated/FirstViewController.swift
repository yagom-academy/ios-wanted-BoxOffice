//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

class FirstViewController: UIViewController, FirstViewControllerRoutable, BasicNavigationBarStyling {

    var model: FirstModel
    
    lazy var contentView: FirstContentView = FirstContentView(viewModel: self.model.firstContentViewModel)
    
    init(viewModel: FirstModel) {
        self.model = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        initViewHierarchy()
        configureView()
        bind()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.populateData()
        // Do any additional setup after loading the view.
    }
}

extension FirstViewController: Presentable {
    func initViewHierarchy() {
        self.view = UIView()
        
        self.view.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        var constraint: [NSLayoutConstraint] = []
        defer { NSLayoutConstraint.activate(constraint) }
        
        constraint += [
            contentView.topAnchor.constraint(equalTo: self.view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
    }
    
    func configureView() {
        view.backgroundColor = .white
        navigationItem.title = "목록"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(dateAction))
        navigationItem.rightBarButtonItem?.addStyles(style: dateButtonStyle)
    }
    
    func bind() {
        model.routeSubject = { [weak self] sceneCategory in
            guard let self = self else { return }
            self.route(to: sceneCategory)
        }
    }
    
    @objc func dateAction() {
        model.didTapCalendarButton()
    }
    
    
}
