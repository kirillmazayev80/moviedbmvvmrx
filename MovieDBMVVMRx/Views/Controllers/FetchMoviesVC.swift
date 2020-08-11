//
//  ViewController.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/11/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class FetchMoviesVC: UIViewController, Storyboarded {

    @IBOutlet weak var moviesTable: UITableView!
    @IBOutlet weak var sortMovieSegmCtrl: UISegmentedControl!
    
    var viewModel: MoviesViewModel?
    weak var coordinator: FetchMoviesCoordinator?
    
    fileprivate var refreshCtrl =  UIRefreshControl()
    fileprivate let disposeBag = DisposeBag()
    
    // UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserInterface()
        bindViewModel()
    }
    
    fileprivate func setUserInterface() {
        moviesTable.addSubview(refreshCtrl)
    }

    fileprivate func bindViewModel() {
        guard let vm = viewModel else { return }
        
        // Input
        // bind movie's tableview with viemodel movies array
        vm.fetchedMovies.asDriver()
            .drive(moviesTable.rx.items(cellIdentifier: Utils.MOVIE_CELL))
            { index, movie, cell in
                guard let cell = cell as? MovieCell else { return }
                cell.configureCell(with: movie)
            }.disposed(by: disposeBag)
        
        moviesTable.rx.itemSelected.subscribe (onNext:
            { [weak self] indexPath in
                guard let `self` = self else { return }
                let movie = vm.fetchedMovies.value[indexPath.row]
                self.coordinator?.transitToOverview(with: movie)
        }).disposed(by: disposeBag)
        
        vm.errorMessages.subscribe (onNext: { [weak self] text in
            guard let `self` = self else { return }
            self.showErrorMessage(title: Strings.REQUEST_ERR_TITLE,
                                  errorText: text)
        }).disposed(by: disposeBag)
        
        // Output
        // bind segmented control to viewmodel type of movies fetching
        sortMovieSegmCtrl.rx.selectedSegmentIndex
            .bind(to: vm.fetchingMoviesType).disposed(by: disposeBag)
        
        // bind movies tableview content off set with viewmodel should load next page flag
        moviesTable.rx_loadNextPageTrigger
            .filter{ $0 == true }
            .subscribe(onNext: { value in
                vm.shouldLoadNextPage.accept(value)
            }).disposed(by: disposeBag)
        
        // bind refresh control value changed event to refresh movies in viewmodel
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
    }
    
}
