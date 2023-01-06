//
//  BoxOfficeListCoordinator.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/03.
//

import UIKit

final class BoxOfficeListCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var type: CoordinatorType { .list }
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    init(navigationConrtoller: UINavigationController) {
        self.navigationController = navigationConrtoller
    }
    
    func start() {
        let viewController = makeBoxOfficeListViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

private extension BoxOfficeListCoordinator {
    
    func makeBoxOfficeListViewController() -> UIViewController {
        let viewController = BoxOfficeListViewController(
            viewModel: DefaultBoxOfficeListViewModel(),
            coordinator: self
        )
        return viewController
    }
    
    func makeMovieDetailViewController(_ movie: Movie) -> UIViewController {
        let viewController = DetailViewController(
            viewModel: MovieDetailViewModel(movie: movie),
            coordinator: self
        )
        return viewController
    }
    
    func makeCreateReviewViewController(movie: Movie) -> UIViewController {
        let navigationController = UINavigationController()
        let coordinator = CreateReviewCoordinator(movie: movie, navigationConrtoller: navigationController)
        coordinator.finishDelegate = self
        coordinator.parentCoordinator = self
        coordinator.start()
        childCoordinators.append(coordinator)
        return navigationController
    }
}

extension BoxOfficeListCoordinator: BoxOfficeListCoordinatorInterface {
    
    func showMovieDetailView(movie: Movie) {
        let viewController = makeMovieDetailViewController(movie)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showCreateReviewView(movie: Movie) {
        let viewController = makeCreateReviewViewController(movie: movie)
        viewController.isModalInPresentation = true
        navigationController.visibleViewController?.present(viewController, animated: true)
    }
    
}

extension BoxOfficeListCoordinator: CoordinatorFinishDelegate {
    
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })
    }
    
}
