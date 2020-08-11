//
//  UINavigationBar+Ext.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/23/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit


extension UINavigationBar {
    
    // set style for navigation bar
    func setStyle(by theme: Theme) {
        self.barStyle = theme.barStyle
    }
    
}
