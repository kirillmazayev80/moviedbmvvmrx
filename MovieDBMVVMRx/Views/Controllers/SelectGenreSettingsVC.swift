//
//  SelectGenreSettingsVC.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/23/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SelectGenreSettingsVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var genresTable: UITableView!
    
    var viewModel: SelectGenreSettingsViewModel?
    weak var coordinator: SelectGenreSettingsCoordinator?
    
    fileprivate let disposeBag = DisposeBag()
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    // MARK: - Custom
    // bind genres table
    fileprivate func bindViewModel() {
        guard let vm = viewModel else { return }
        
        //binding data source
        vm.genres.asDriver()
            .drive(genresTable.rx.items(cellIdentifier: Utils.GENRE_CELL))
            { index, genre, cell in
                cell.textLabel?.text = genre.name
                if genre.name == UserDefaults.standard.string(forKey: Utils.GENRE_NAME) {
                    cell.setCellType(.checkmark, .lightGray, .white)
                } else {
                    cell.setCellType(.none, .white, .black)
                }
            }.disposed(by: disposeBag)
        
        // binding did select delegate
        genresTable.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let `self` = self else { return }
                let tappedGenre = vm.genres.value[indexPath.row]
                vm.storeGenre(tappedGenre)
                self.genresTable.reloadData()
        }).disposed(by: disposeBag)
        
        // show error and reachability alerts
        vm.errorMessages.subscribe (onNext: { [weak self] text in
            guard let `self` = self else { return }
            self.showErrorMessage(title: Strings.REQUEST_ERR_TITLE,
                                  errorText: text)
        }).disposed(by: disposeBag)
    }
    
}
