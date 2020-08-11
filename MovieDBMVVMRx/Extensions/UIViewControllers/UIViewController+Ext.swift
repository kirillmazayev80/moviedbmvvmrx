//
//  UIViewController+Ext.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/15/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit
import Toast_Swift
import RxSwift
import RxGesture

extension UIViewController {
    
    // show ok style alert with error message on view controller
    func showErrorMessage(title: String, errorText: String) {
        let alertController = UIAlertController(title: title,
                                                message: errorText,
                                                preferredStyle: .alert)
        present(alertController, animated: true, completion: nil)
        let actionOk = UIAlertAction(title: Strings.OK,
                                     style: .default,
                                     handler: nil )
        alertController.addAction(actionOk)
    }
    
    // show toast with message
    func makeToast(with message: String) {
        let coordX: CGFloat = self.view.frame.width / 2
        let coordY: CGFloat = self.view.frame.height - Dims.TOAST_PADD_Y
        let point = CGPoint.init(x: coordX, y: coordY)
        view.makeToast(message, point: point, title: nil,
                       image: nil, completion: nil)
    }
    
}
