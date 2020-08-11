//
//  SelectThemeSettingsVC.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/23/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SelectThemeSettingsVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var themesTable: UITableView!
    
    var viewModel: SelectThemeSettingsViewModel?
    weak var coordinator: SelectThemeSettingsCoordinator?
    
    fileprivate let disposeBag = DisposeBag()
    
    // UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    // bind themes table
    fileprivate func bindViewModel() {
        guard let vm = viewModel else { return }
        // binding themes data source
        vm.themes.asDriver()
            .drive(themesTable.rx.items(cellIdentifier: Utils.THEME_CELL))
            { index, theme, cell in
                let currentTheme = ThemeManager.currentTheme()
                cell.textLabel?.text = theme.rawValue
                if theme == currentTheme {
                    cell.setCellType(.checkmark, .lightGray, .white)
                } else {
                    cell.setCellType(.none, .white, .black)
                }
            }.disposed(by: disposeBag)
        
        // binding did select delegate
        themesTable.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let `self` = self else { return }
                let selectedTheme = vm.themes.value[indexPath.row]
                vm.applyTheme(selectedTheme)
                self.navigationController?.navigationBar.setStyle(by: selectedTheme)
                self.themesTable.reloadData()
            }).disposed(by: disposeBag)
    }
    
}
