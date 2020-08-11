//
//  SearchMoviesCoordinator.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/16/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit

class SearchMoviesCoordinator: NSObject, Coordinator,
UINavigationControllerDelegate {
    
    
    fileprivate var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.delegate = self
        let vc = SearchMoviesVC.instantiate(sbName: Utils.SEARCH_MOVIES_SB)
        let vcTitle = Strings.SEARCH
        vc.tabBarItem.setTabBarItemType(title: vcTitle, imageName: Utils.SEARCH_TB_ICON)
        vc.viewModel = SearchViewModel()
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
