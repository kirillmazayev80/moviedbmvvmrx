//
//  ActorsListVC.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/23/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ActorsListVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var actorsTable: UITableView!
    
    var viewModel: ActorsListViewModel?
    weak var coordinator: ActorsListCoordinator?
    
    fileprivate var refreshCtrl =  UIRefreshControl()
    fileprivate let disposeBag = DisposeBag()
    
    // UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserInterface()
        bindViewModel()
    }
    
    fileprivate func setUserInterface() {
        actorsTable.addSubview(refreshCtrl)
    }
    
    // Bind actors table
    fileprivate func bindViewModel() {
        guard let vm = viewModel else { return }
        
        vm.actors.asDriver()
            .drive(actorsTable.rx.items(cellIdentifier: Utils.ACTOR_CELL))
            { index, movie, cell in
                guard let cell = cell as? ActorCell else { return }
                cell.configureCell(with: movie)
            }.disposed(by: disposeBag)
        
        actorsTable.rx_loadNextPageTrigger
            .subscribe(onNext: { value in
                vm.shouldLoadNextPage.accept(value)
            }).disposed(by: disposeBag)
        
        actorsTable.rx.itemSelected.subscribe (onNext:
            { [weak self] indexPath in
                guard let `self` = self else { return }
                let actor = vm.actors.value[indexPath.row]
                self.coordinator?.transitToBio(with: actor.id)
        }).disposed(by: disposeBag)
        
        refreshCtrl.rx.controlEvent(.valueChanged).asObservable()
            .subscribe (onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.refreshCtrl.beginRefreshing()
                vm.refreshMovies()
            }).disposed(by: disposeBag)
        
        vm.stopRefreshing
            .filter{ $0 == true }
            .subscribe{ [weak self] value in
                guard let `self` = self else { return }
                self.refreshCtrl.endRefreshing()
            }.disposed(by: disposeBag)
        
        vm.errorMessages
            .subscribe (onNext: { [weak self] text in
                guard let `self` = self else { return }
                self.showErrorMessage(title: Strings.REQUEST_ERR_TITLE,
                                      errorText: text)
            }).disposed(by: disposeBag)
        
    }
    
}
