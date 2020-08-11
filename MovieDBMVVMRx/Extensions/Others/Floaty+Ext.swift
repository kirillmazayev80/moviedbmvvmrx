//
//  Floaty+Ext.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/15/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit
import Floaty


extension Floaty {
    
    func setProperties(size: CGFloat = 56,
                       paddX: CGFloat = 14,
                       paddY: CGFloat = 14,
                       btnColor: UIColor = UIColor(red: 73/255.0,
                                                   green: 151/255.0,
                                                   blue: 241/255.0, alpha: 1),
                       btnImage: UIImage? = nil,
                       tag: Int = 0,
                       friendlyTap: Bool = false) {
        self.size = size
        self.paddingX = paddX
        self.paddingY = paddY
        self.buttonColor = btnColor
        self.buttonImage = btnImage
        self.tag = tag
        self.friendlyTap = friendlyTap
    }
    
    func setAddButton() {
        setProperties(paddY: 64,
                      btnColor: Colors.GREEN,
                      btnImage: UIImage(named: Utils.ADD_FAB_ICON),
                      tag: Utils.FAB_TAG)
    }
    
    func setDeleteButton(frame: CGRect) {
        setProperties(size: 42,
                      paddX: frame.width - 56,
                      paddY: frame.height - 120,
                      btnColor: Colors.RED,
                      btnImage: UIImage(named: Utils.DELETE_FAB_ICON),
                      tag: Utils.FAB_TAG)
    }
    
}
