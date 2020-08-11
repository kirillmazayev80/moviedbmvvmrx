//
//  Storyboarded.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/11/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit

protocol Storyboarded {
    static func instantiate(sbName: String) -> Self
}

extension Storyboarded where Self: UIViewController {
    
    static func instantiate(sbName: String) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: sbName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
    
}
