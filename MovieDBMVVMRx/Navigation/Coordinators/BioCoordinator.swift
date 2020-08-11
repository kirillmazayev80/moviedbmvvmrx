//
//  BioCoordinator.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/23/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit

class BioCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    fileprivate var actorId: Int
    
    
    init(navigationController: UINavigationController, actorId: Int) {
        self.navigationController = navigationController
        self.actorId = actorId
    }
    
    func start() {
        navigationController.navigationBar.prefersLargeTitles = true
        let vc = BiographyVC.instantiate(sbName: Utils.ACTORS_LIST_SB)
        let viewModel = BioViewModel(actorId: actorId)
        vc.viewModel = viewModel
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func transitToHomePage(with homePageUrlStr: String) {
        let child = HomePageCoordinator(navigationController: navigationController, homePageUrlStr: homePageUrlStr)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    // UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from)
            else { return }
        if navigationController.viewControllers.contains(fromViewController) { return }
        if let homePageVC = fromViewController as? HomePageVC,
            let coordinator = homePageVC.coordinator {
            childDidFinish(coordinator)
        }
    }
    
}
