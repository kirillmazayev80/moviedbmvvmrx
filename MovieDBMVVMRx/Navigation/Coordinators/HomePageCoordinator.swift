//
//  HomePageCoordinator.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/23/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit

class HomePageCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    fileprivate var homePage: String
    
    
    init(navigationController: UINavigationController, homePageUrlStr: String) {
        self.navigationController = navigationController
        self.homePage = homePageUrlStr
    }
    
    func start() {
        navigationController.navigationBar.prefersLargeTitles = true
        let vc = HomePageVC.instantiate(sbName: Utils.ACTORS_LIST_SB)
        vc.homePage = self.homePage
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
}
