//
//  Theme.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/23/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit

enum Theme: String {
    
    case light = "Light"
    case dark = "Dark"
    
    //Customizing the navigation bar
    var barStyle: UIBarStyle {
        switch self {
            case .light: return .default
            case .dark: return .black
        }
    }
    
}
