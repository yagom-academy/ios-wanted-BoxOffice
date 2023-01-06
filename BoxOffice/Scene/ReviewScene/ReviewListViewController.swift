//
//  ReviewListViewController.swift
//  BoxOffice
//
//  Created by 김주영 on 2023/01/06.
//

import UIKit

class ReviewListViewController: UIViewController {
    private let reviewViewModel: MovieReviewViewModel
    private let movieTitle: String
    private let reviewTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ReviewTableViewCell.self,
                           forCellReuseIdentifier: "ReviewTableViewCell")
        return tableView
    }()
    
    init(movieTitle: String, viewModel: MovieReviewViewModel) {
        self.reviewViewModel = viewModel
        self.movieTitle = movieTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupView()
    }
    
    private func setupView() {
        navigationItem.title = movieTitle
        view.backgroundColor = .systemBackground
        view.addSubview(reviewTableView)
        
        NSLayoutConstraint.activate([
            reviewTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            reviewTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            reviewTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            reviewTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

//MARK: Review TableView
extension ReviewListViewController: UITableViewDataSource {
    private func setupTableView() {
        reviewTableView.dataSource = self
        reviewTableView.rowHeight = view.bounds.height * 0.1
        reviewTableView.allowsSelection = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewViewModel.reviews.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier,
                                                       for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
        let review = reviewViewModel.reviews.value[indexPath.row]
        cell.configure(with: review)
        
        return cell
    }
}
