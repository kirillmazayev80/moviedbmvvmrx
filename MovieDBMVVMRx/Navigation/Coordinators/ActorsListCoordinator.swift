//
//  ActorsListCoordinator.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/23/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit

class ActorsListCoordinator: NSObject, Coordinator,
UINavigationControllerDelegate {
    
    fileprivate var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.delegate = self
        let vc = ActorsListVC.instantiate(sbName: Utils.ACTORS_LIST_SB)
        let vcTitle = Strings.ACTORS
        vc.tabBarItem.setTabBarItemType(title: vcTitle, imageName: Utils.ACTOR_TB_ICON)
        vc.viewModel = ActorsListViewModel()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func transitToBio(with actorId: Int) {
        let child = BioCoordinator(navigationController: navigationController, actorId: actorId)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    // UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from)
            else { return }
        if navigationController.viewControllers.contains(fromViewController) { return }
        if let biographyVC = fromViewController as? BiographyVC,
            let coordinator = biographyVC.coordinator {
            childDidFinish(coordinator)
        }
    }
    
}
