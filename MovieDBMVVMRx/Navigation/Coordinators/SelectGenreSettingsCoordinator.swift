//
//  SelectGenreSettingsCoordinator.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/23/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit

class SelectGenreSettingsCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.navigationBar.prefersLargeTitles = true
        let vc = SelectGenreSettingsVC.instantiate(sbName: Utils.APP_SETTINGS_SB)
        let viewModel = SelectGenreSettingsViewModel()
        vc.viewModel = viewModel
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
}
