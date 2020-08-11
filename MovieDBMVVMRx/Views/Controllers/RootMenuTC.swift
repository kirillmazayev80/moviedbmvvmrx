//
//  RootMenuTC.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/11/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit

class RootMenuTC: UITabBarController {
    
    let  searchMoviesCoord = SearchMoviesCoordinator(navigationController: UINavigationController())
    let favoritesMoviesCoord = FavoritesMoviesCoordinator(navigationController: UINavigationController())
    let fetchMoviesCoord = FetchMoviesCoordinator(navigationController: UINavigationController())
    let actorsListCoord = ActorsListCoordinator(navigationController: UINavigationController())
    let appSettingsCoord = AppSettingsCoordinator(navigationController: UINavigationController())
    fileprivate let centralTabBarItemIndex = 2
    
    
    // UITabBarController
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserInterface()
    }
    
    // Set user interface
    fileprivate func setUserInterface() {
        setItemViewControllers()
        setMiddleButton()
        setCurrentTheme()
    }
    
    fileprivate func setItemViewControllers() {
        [searchMoviesCoord, favoritesMoviesCoord,
         fetchMoviesCoord, actorsListCoord, appSettingsCoord]
            .forEach( { ($0 as! Coordinator).start()})
        
        viewControllers = [
            searchMoviesCoord.navigationController,
            favoritesMoviesCoord.navigationController,
            fetchMoviesCoord.navigationController,
            actorsListCoord.navigationController,
            appSettingsCoord.navigationController
        ]
    }
    
    fileprivate func setMiddleButton() {
        setupMiddleButton()
        selectedIndex = centralTabBarItemIndex
    }
    
    fileprivate func setCurrentTheme() {
        let currTheme = ThemeManager.currentTheme()
        ThemeManager.applyTheme(theme: currTheme)
    }
    
}
