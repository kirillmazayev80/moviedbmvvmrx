//
//  AppSettingsVC+DataSource.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/23/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit

extension AppSettingsVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vm = viewModel else { return UITableViewCell() }
        let cell  = tableView.dequeueReusableCell(withIdentifier: Utils.SETTINGS_CELL, for: indexPath)
        switch (indexPath.section) {
        case 0: cell.textLabel?.text = vm.selectedTheme.value?.rawValue
        case 1: cell.textLabel?.text = vm.selectedGenreName.value
        default: break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case 0: return Strings.SELECT_THEME
        case 1: return Strings.SELECT_GENRE
        default: return nil
        }
    }
    
}
