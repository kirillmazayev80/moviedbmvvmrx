//
//  FetchMoviesCoordinator.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/11/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit

class FetchMoviesCoordinator: NSObject, Coordinator,
UINavigationControllerDelegate {
    
    fileprivate var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        navigationController.navigationBar.prefersLargeTitles = true
        let vc = FetchMoviesVC.instantiate(sbName: Utils.MOVIES_LIST_SB)
        vc.viewModel = MoviesViewModel()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func transitToOverview(with movie: Movie) {
        let child = MovieOverviewCoordinator(navigationController: navigationController, movie: movie)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    // UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from)
            else { return }
        if navigationController.viewControllers.contains(fromViewController) { return }
        if let movieOverviewVC = fromViewController as? OverviewMovieVC,
            let coordinator = movieOverviewVC.coordinator {
            childDidFinish(coordinator)
        }
    }
    
}
