//
//  AppSettingsVC.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/23/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AppSettingsVC: UITableViewController, Storyboarded {
    
    var viewModel: AppSettingsViewModel?
    weak var coordinator: AppSettingsCoordinator?
    
    fileprivate let disposeBag = DisposeBag()
    
    // UITableViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        guard let vm = self.viewModel else { return }
        vm.updateSettings()
        tableView.reloadData()
    }
    
    // bind settings table
    fileprivate func bindViewModel() {
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let `self` = self else { return }
                switch (indexPath.section) {
                case 0: self.coordinator?.transitToSelectThemeSettings()
                case 1: self.coordinator?.transitToSelectGenreSettings()
                default: return
                }
            }).disposed(by: disposeBag)
    }
    
}
