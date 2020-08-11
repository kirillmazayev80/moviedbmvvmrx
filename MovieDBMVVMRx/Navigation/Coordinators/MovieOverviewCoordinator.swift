//
//  MovieOverviewCoordinator.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/14/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit

class MovieOverviewCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    fileprivate var movie: Movie
    
    
    init(navigationController: UINavigationController, movie: Movie){
        self.navigationController = navigationController
        self.movie = movie
    }
    
    func start() {
        navigationController.navigationBar.prefersLargeTitles = true
        let vc = OverviewMovieVC.instantiate(sbName: Utils.MOVIE_OVERVIEW_SB)
        let viewModel = OverviewViewModel(movie: movie)
        vc.viewModel = viewModel
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
}
