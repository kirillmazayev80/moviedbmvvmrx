//
//  ThemeManager.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/23/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit

class ThemeManager {
    
    // returns current theme
    static func currentTheme() -> Theme? {
        guard let storedTheme = UserDefaults.standard.string(forKey: Utils.APP_THEME) else { return nil }
        switch (storedTheme) {
            case "Light": return .light
            case "Dark": return .dark
            default: return nil
        }
    }
    
    // applies current theme for tabbar & navigation controllers
    static func applyTheme(theme: Theme?) {
        guard let theme = theme else { return }
        UserDefaults.standard.setValue(theme.rawValue, forKey: Utils.APP_THEME)
        UINavigationBar.appearance().barStyle = theme.barStyle
    }
    
}
