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
    var finishDelegate: CoordinatorFinishDelegate?
    
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
    
    func makeMovieDetailViewController() -> UIViewController {
        let viewController = DetailViewController()
        return viewController
    }
    
    func makeCreateReviewViewController() -> UIViewController {
        let viewController = UIViewController()
        return viewController
    }
}

extension BoxOfficeListCoordinator: BoxOfficeListCoordinatorInterface {
    
    func showMovieDetailView(movie: Movie) {
        let viewController = makeMovieDetailViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showCreateReviewView(movie: Movie) {
        let viewController = makeCreateReviewViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
