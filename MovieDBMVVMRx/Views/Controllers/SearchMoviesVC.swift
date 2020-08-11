//
//  SearchMoviesVC.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/16/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxBiBinding

class SearchMoviesVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var resultsTable: UITableView!
    
    var viewModel: SearchViewModel?
    weak var coordinator: SearchMoviesCoordinator?
    
    fileprivate var searchString = BehaviorRelay(value: "")
    fileprivate var currentText = ""
    fileprivate let disposeBag = DisposeBag()
    
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserInterface()
        bindViewModel()
    }
    
    // MARK: - Set user interface
    fileprivate func setUserInterface() {
        setSearchController()
        //resultsTable.addSubview(refreshCtrl)
    }
    
    // setting search controller
    fileprivate func setSearchController() {
        let searchCtrl = UISearchController(searchResultsController: nil)
        searchCtrl.searchBar.delegate = self
        searchCtrl.searchResultsUpdater = self
        searchCtrl.setSearchControllerProperties(viewController: self)
    }
    
    // MARK: - Bindings
    fileprivate func bindViewModel() {
        guard let vm = viewModel else { return }
        
        // Input
        (vm.searchString <-> searchString).disposed(by: disposeBag)
        
        vm.fetchedMovies.asDriver()
            .drive(resultsTable.rx.items(cellIdentifier: Utils.MOVIE_CELL))
            { index, movie, cell in
                guard let cell = cell as? MovieCell else { return }
                cell.configureCell(with: movie)
            }.disposed(by: disposeBag)
        
        vm.errorMessages
            .subscribe (onNext: { [weak self] text in
                guard let `self` = self else { return }
                self.showErrorMessage(title: Strings.REQUEST_ERR_TITLE,
                                      errorText: text)
            }).disposed(by: disposeBag)
        
        resultsTable.rx.itemSelected
            .subscribe (onNext: { [weak self] indexPath in
                guard let `self` = self else { return }
                self.currentText = self.searchString.value
                let movie = vm.fetchedMovies.value[indexPath.row]
                self.coordinator?.transitToOverview(with: movie)
            }).disposed(by: disposeBag)
        
        // Output
        resultsTable.rx_loadNextPageTrigger
            .subscribe(onNext: { value in
                vm.shouldLoadNextPage.accept(value)
        }).disposed(by: disposeBag)
    }
    
}

// UISearchResultUpdating
extension SearchMoviesVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text != currentText {
            //searchString.value = text
            searchString.accept(text)
        }
    }
    
}

// UISearchBarDelegate
extension SearchMoviesVC: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard let vm = viewModel else { return }
        vm.clearResultsTable()
        currentText = ""
    }
    
}
