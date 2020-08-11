//
//  AppSettingsViewModel.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/23/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import RxSwift
import RxCocoa

class AppSettingsViewModel: Messagable {
    
    let selectedTheme = BehaviorRelay<Theme?>(value: nil)
    let selectedGenreName = BehaviorRelay<String?>(value: nil)
    var errorMessages = PublishSubject<String>()
    
    init() {
        self.setSettings()
    }
    
    fileprivate func setSettings() {
        selectedTheme.accept(ThemeManager.currentTheme())
        let genreName = UserDefaults.standard.string(forKey: Utils.GENRE_NAME)
        selectedGenreName.accept(genreName)
    }
    
    func updateSettings() {
        setSettings()
    }
    
}
