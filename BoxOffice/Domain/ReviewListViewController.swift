//
//  ReviewListViewController.swift
//  BoxOffice
//
//  Created by Ellen J on 2023/01/04.
//

import UIKit
import Combine

final class ReviewListViewController: UIViewController,  UICollectionViewDelegate{
    
    typealias ReviewDataSource = UITableViewDiffableDataSource<ReviewSection, Comment>
    typealias ReviewSnapshot = NSDiffableDataSourceSnapshot<ReviewSection, Comment>
    
    enum ReviewSection: Hashable {
        case CommentSection
    }
    
    private var reviewListViewModel: ReviewListViewModelInterface?
    private lazy var dataSource = createDataSource()
    private var cancelable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        reviewListViewModel?.input.onViewDidLoad()
        setup()
        setupConstraints()
        bind()
    }
    
    static func instance(_ viewModel: ReviewListViewModelInterface) -> ReviewListViewController {
        let viewController = ReviewListViewController(nibName: nil, bundle: nil)
        viewController.reviewListViewModel = viewModel
        return viewController
    }
    
    private func bind() {
        guard let reviewListViewModel = reviewListViewModel else { return }
        
        reviewListViewModel.output.commentPublisher.receive(on: DispatchQueue.main)
            .sink { [weak self] comments in
                guard let self = self else { return }
                self.applySnapshot(models: comments)
            }
            .store(in: &cancelable)
    }
    
    private lazy var averageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "평균 평점: "
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    private lazy var averageRateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.setStarLabel("0.0")
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.rowHeight = 130        
        return tableView
    }()
    
    private func setup() {
        tableView.register(ReviewListCell.self, forCellReuseIdentifier: ReviewListCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        view.addSubviews(
        averageLabel,
        averageRateLabel,
        tableView
        )
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            averageLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            averageLabel.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            averageRateLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor),
            averageRateLabel.topAnchor.constraint(equalTo: view.topAnchor),
            averageRateLabel.heightAnchor.constraint(greaterThanOrEqualTo: averageLabel.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: averageRateLabel.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
}

extension ReviewListViewController {
    
    private func createDataSource() -> ReviewDataSource {
        let datasource =
        ReviewDataSource(tableView: self.tableView) {
            tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewListCell.identifier, for: indexPath) as? ReviewListCell else {
                return UITableViewCell()
            }
            cell.configureCell(itemIdentifier, row: indexPath.row)
            cell.delegate = self
            return cell
        }
        return datasource
    }
    
    private func applySnapshot(models: [Comment]) {
        var snapshot = ReviewSnapshot()
        
        snapshot.appendSections([.CommentSection])
    
        snapshot.appendItems(models)
        dataSource.apply(snapshot)
    }
    
    private func showDeleteAlert(comment: Comment) {
        let controller = UIAlertController(title: "삭제", message: "비밀번호를 입력해주십시오.", preferredStyle: .alert)
        controller.addTextField()
        let okAction = UIAlertAction(title: "확인", style: .default) { [weak self] action in
            if let textField = controller.textFields {
                if comment.password == textField.first?.text {
                    self?.reviewListViewModel?.input.deleteComment(comment: comment)
                }
            }
        }
        let cancleAction = UIAlertAction(title: "취소", style: .cancel)
        controller.addAction(cancleAction)
        controller.addAction(okAction)
        self.present(controller, animated: true)
    }
}

extension ReviewListViewController: ReviewListDelegate {
    func deleteComment(comment: Comment) {
        showDeleteAlert(comment: comment)
    }
}
