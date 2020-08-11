//
//  UIView+Ext.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/16/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit

extension UIView {
    
    // set corner radius for view
    func setCornerRadius(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
}
