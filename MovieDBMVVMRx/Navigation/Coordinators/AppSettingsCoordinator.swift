//
//  AppSettingsCoordinator.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/23/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit

class AppSettingsCoordinator: NSObject, Coordinator,
UINavigationControllerDelegate {
    
    fileprivate var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.navigationBar.prefersLargeTitles = true
        let vc = AppSettingsVC.instantiate(sbName: Utils.APP_SETTINGS_SB)
        let vcTitle = Strings.SETTINGS
        vc.tabBarItem.setTabBarItemType(title: vcTitle, imageName: Utils.APPSETT_TB_ICON)
        vc.viewModel = AppSettingsViewModel()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func transitToSelectThemeSettings() {
        let child = SelectThemeSettingsCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func transitToSelectGenreSettings() {
        let child = SelectGenreSettingsCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    // UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from)
            else { return }
        if navigationController.viewControllers.contains(fromViewController) { return }
        if let selectThemeSettingsVC = fromViewController as? SelectThemeSettingsVC,
            let coordinator = selectThemeSettingsVC.coordinator {
            childDidFinish(coordinator)
        }
        if let selectGenreSettingsVC = fromViewController as? SelectGenreSettingsVC,
            let coordinator = selectGenreSettingsVC.coordinator {
            childDidFinish(coordinator)
        }
    }
    
}
