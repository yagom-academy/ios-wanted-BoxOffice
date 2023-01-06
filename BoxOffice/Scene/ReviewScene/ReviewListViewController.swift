//
//  ReviewListViewController.swift
//  BoxOffice
//
//  Created by 김주영 on 2023/01/06.
//

import UIKit

final class ReviewListViewController: UIViewController {
    private let reviewViewModel: MovieReviewViewModel
    private let movie: MovieData
    private let reviewTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ReviewTableViewCell.self,
                           forCellReuseIdentifier: ReviewTableViewCell.identifier)
        return tableView
    }()
    
    init(movie: MovieData, viewModel: MovieReviewViewModel) {
        self.reviewViewModel = viewModel
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupView()
        bind()
    }
    
    private func setupView() {
        navigationItem.title = movie.title
        view.backgroundColor = .systemBackground
        view.addSubview(reviewTableView)
        
        NSLayoutConstraint.activate([
            reviewTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            reviewTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            reviewTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            reviewTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func bind() {
        reviewViewModel.reviews.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.reviewTableView.reloadData()
            }
        }
        
        reviewViewModel.error.bind { [weak self] error in
            DispatchQueue.main.async {
                if let description = error {
                    self?.showAlert(message: description)
                }
            }
        }
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
        cell.addTargetDeleteButton(with: self,
                                   selector: #selector(reviewDeleteButtonTapped),
                                   tag: indexPath.row)
        
        return cell
    }
    
    @objc private func reviewDeleteButtonTapped(button: UIButton) {
        let review = reviewViewModel.reviews.value[button.tag]
        let checkPasswordAlert = UIAlertController(title: "리뷰 삭제",
                                                   message: "암호를 입력해주세요.",
                                                   preferredStyle: .alert)
        checkPasswordAlert.addTextField()
        
        let confirmAction = UIAlertAction(title: "확인", style: .default) { [self] _ in
            let inputPassword = checkPasswordAlert.textFields?.first?.text
            if inputPassword == review.password {
                reviewViewModel.delete(review,
                                       at: movie.title + movie.openYear)
            } else {
                showAlert(title: "리뷰 삭제 실패",
                          message: "암호가 일치하지 않습니다.")
            }
        }
        
        checkPasswordAlert.addAction(confirmAction)
        checkPasswordAlert.addAction(UIAlertAction(title: "취소",
                                                   style: .cancel))
        present(checkPasswordAlert, animated: true)
    }
}
