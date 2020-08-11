//
//  UITabBarItem+Ext.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/16/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit

extension UITabBarItem {
    
    //set type of tab bar item by image & title
    func setTabBarItemType(title: String, imageName: String) {
        self.title = title
        image = UIImage(named: imageName)
    }
    
}
