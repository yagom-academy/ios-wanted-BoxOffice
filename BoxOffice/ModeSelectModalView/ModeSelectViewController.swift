//
//  ModeSelectViewController.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/03.
//

import UIKit

protocol ModeSelectViewControllerDelegate: AnyObject {
    func didSelectedRowAt(indexPath: Int)
}

final class ModeSelectViewController: UIViewController {
    weak var delegate: ModeSelectViewControllerDelegate?
    private let passedMode: String
    private let customTransitioningDelegate = ModeSelectTransitioningDelegate()
    private var selectList = ["일별 박스오피스", "주간/주말 박스오피스"]
    
    private let navigationBar = UINavigationBar(frame: .zero)
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(passMode: String) {
        self.passedMode = passMode
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
        layoutNavigationBar()
        setupTableView()
        layoutTableView()
    }
    
    private func setupModalStyle() {
        modalPresentationStyle = .custom
        modalTransitionStyle = .coverVertical
        transitioningDelegate = customTransitioningDelegate
     
    }
    
    private func setupInitialView() {
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
    }
    
    private func setupNavigationBar() {
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.isTranslucent = false
        navigationBar.backgroundColor = .systemBackground

        let naviItem = UINavigationItem(title: "보기 모드")
        naviItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(dismissView)
        )
        navigationBar.items = [naviItem]
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ModeSelectCell.self,
                           forCellReuseIdentifier: "modalCell")
    }
    
    @objc private func dismissView() {
        self.dismiss(animated: true)
    }
}

extension ModeSelectViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectList.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "modalCell",
            for: indexPath
        ) as? ModeSelectCell else {
            return UITableViewCell(style: .default, reuseIdentifier: .none)
        }
        let modeName = selectList[indexPath.row]
        
        cell.setup(label: modeName, isChecked: passedMode == modeName)
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectedRowAt(indexPath: indexPath.row)
        dismiss(animated: true)
    }
}

// MARK: Setup Layout
private extension ModeSelectViewController {
    func layoutNavigationBar() {
        view.addSubview(navigationBar)
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    func layoutTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
