//
//  SelectThemeSettingsViewModel.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/23/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import RxSwift
import RxCocoa

class SelectThemeSettingsViewModel {
    
    let themes = BehaviorRelay<[Theme]>(value: [.light, .dark])
    
    func applyTheme(_ selectedTheme: Theme) {
        switch (selectedTheme) {
            case .light: ThemeManager.applyTheme(theme: selectedTheme)
            case .dark: ThemeManager.applyTheme(theme: selectedTheme)
        }
    }
    
}
