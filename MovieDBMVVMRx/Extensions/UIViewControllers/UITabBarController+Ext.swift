//
//  UITabBarControllerExt.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/11/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit

extension UITabBarController {
    
    // middle button size
    fileprivate var btnSize: CGFloat { return Dims.CENTRAL_BTN_SIZE }
    
    // Setup central middle button
    func setupMiddleButton() {
        let middleBtn = UIButton(frame: frameMiddleButton())
        let btnImage = UIImage(named: Utils.MOVIE_TB_ICON)
        middleBtn.setImage(btnImage, for: .normal)
        middleBtn.backgroundColor = Colors.PURPLE
        middleBtn.layer.cornerRadius = btnSize / 2
        middleBtn.clipsToBounds = true
        tabBar.addSubview(middleBtn)
        middleBtn.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        view.layoutIfNeeded()
    }
    
    // Define middle button frame
    fileprivate func frameMiddleButton() -> CGRect {
        let coordX: CGFloat = (view.bounds.width / 2) - (btnSize / 2)
        let coordY: CGFloat = Dims.CENTRAL_BTN_PADD_Y
        let width: CGFloat = btnSize
        let height: CGFloat = btnSize
        return CGRect(x: coordX, y: coordY, width: width, height: height)
    }
    
    // Middle button touch action
    @objc func menuButtonAction(sender: UIButton) {
        selectedIndex = Dims.CENTRAL_ITEM_INDEX
    }
    
}

