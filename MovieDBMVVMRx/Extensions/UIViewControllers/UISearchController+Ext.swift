//
//  UISearchController+Ext.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/16/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit


extension UISearchController {
    
    // Setup search controller for view controller
    func setSearchControllerProperties(viewController: UIViewController) {
        obscuresBackgroundDuringPresentation = false
        searchBar.placeholder = Strings.SEARCH
        viewController.navigationItem.searchController = self
        viewController.navigationItem.hidesSearchBarWhenScrolling = false
        viewController.definesPresentationContext = true
    }
    
}
