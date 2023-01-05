//
//  DetailViewController.swift
//  BoxOffice
//
//  Created by Ellen J on 2023/01/04.
//

import UIKit
import Combine

final class DetailViewController: UIViewController {
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = UIColor(r: 76, g: 52, b: 145)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = DetailSegmentControl(items: ["상세 정보", "리뷰"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    private lazy var pageViewController: UIPageViewController = {
        let viewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil
        )
        viewController.setViewControllers(
            [self.dataViewControllers[0]],
            direction: .forward,
            animated: true
        )
        viewController.delegate = self
        viewController.dataSource = self
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        return viewController
    }()
    
    var dataViewControllers: [UIViewController] {
        guard let detailInfoViewController = detailInfoViewController else {
            return [UIViewController()]
        }
        guard let reviewListViewController = reviewListViewController else {
            return [UIViewController()]
        }
        return [detailInfoViewController, reviewListViewController]
    }
    
    var currentPage: Int = 0 {
        didSet {
            let direction: UIPageViewController.NavigationDirection = oldValue <= self.currentPage ? .forward : .reverse
            self.pageViewController.setViewControllers(
                [dataViewControllers[self.currentPage]],
                direction: direction,
                animated: true,
                completion: nil
            )
        }
    }
    
    private var detailInfoViewController: DetailInfoViewController?
    private var reviewListViewController: ReviewListViewController?
    private var cancelable = Set<AnyCancellable>()
    private var detailViewModel: DetailViewModelInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setup()
        setupConstraints()
        bind()
        detailViewModel?.input.onViewDidLoad()
    }
    
    static func instance(_ viewModel: DetailViewModelInterface, model: CustomBoxOffice) -> DetailViewController {
        let viewController = DetailViewController(nibName: nil, bundle: nil)
        viewController.detailViewModel = viewModel
        viewController.detailInfoViewController = DetailInfoViewController.instance( DetailInfoViewModel(customBoxOffice: model))
        viewController.reviewListViewController = ReviewListViewController.instance(
            ReviewListViewModel(detailBoxOffice: model))
        return viewController
    }
    
    private func setup() {
        view.addSubviews(
            posterImageView,
            segmentedControl,
            pageViewController.view
        )
        
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 15, weight: .semibold)
        ], for: .normal)
        segmentedControl.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                .font: UIFont.systemFont(ofSize: 15, weight: .bold)
            ],
            for: .selected
        )
        segmentedControl.addTarget(self, action: #selector(changeValue(control:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        changeValue(control: segmentedControl)
    }
    
    private func setupConstraints() {
        // MARK: - posterImageView
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: view.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: segmentedControl.topAnchor)
        ])
        
        
        // MARK: - segmenControl
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.centerYAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -5),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5),
            segmentedControl.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // MARK: - pageViewController.view
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bind() {
        guard let detailViewModel = detailViewModel else { return }
        
        detailViewModel.output.detailBoxOfficePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                guard let self = self else { return }
                self.posterImageView.loadImage(from: model.posterURL)
            }
            .store(in: &cancelable)
    }
    
    @objc private func changeValue(control: UISegmentedControl) {
        currentPage = control.selectedSegmentIndex
    }
}

extension DetailViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController),
              index - 1 >= 0 else { return nil }
        
        return dataViewControllers[index - 1]
    }
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController),
              index + 1 < dataViewControllers.count else { return nil }
        
        return dataViewControllers[index + 1]
    }
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        guard let viewController = pageViewController.viewControllers?[0],
              let index = self.dataViewControllers.firstIndex(of: viewController) else { return }
        self.currentPage = index
        self.segmentedControl.selectedSegmentIndex = index
    }
}
