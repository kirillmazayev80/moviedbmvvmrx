//
//  UITableViewCellExt.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/11/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    // set cell type by properties
    func setCellType(_ type: UITableViewCell.AccessoryType,
                     _ backgroungColor: UIColor,
                     _ textColor: UIColor) {
        accessoryType = type
        backgroundColor = backgroungColor
        textLabel?.textColor = textColor
    }
    
    // set card view properties for cell
    func setCardViewProperties() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
    }
    
}
