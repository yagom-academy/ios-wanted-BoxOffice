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
    
    private lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["일간", "주간", "주말"])
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(didTapSegmented(_:)), for: .valueChanged)
        return control
      }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 130
        tableView.backgroundColor = .boBackground
        tableView.register(MovieCell.self)
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
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

private extension BoxOfficeListViewController {
    
    func setUp() {
        setUpNavigationBar()
        setUpView()
    }
    
    func setUpNavigationBar() {
        navigationItem.title = "BoxOffice"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setUpView() {
        view.backgroundColor = .boBackground
        view.addSubviews(segmentedControl, tableView)
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30),
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    @objc func didTapSegmented(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
    }
}

extension BoxOfficeListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(MovieCell.self, for: indexPath) else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
}
