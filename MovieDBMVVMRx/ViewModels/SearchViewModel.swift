//
//  SearchViewModel.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/16/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import RxSwift
import RxCocoa

class SearchViewModel: Messagable {
    
    var fetchedMovies = BehaviorRelay(value: [Movie]())
    var errorMessages = PublishSubject<String>()
    let searchString = BehaviorRelay(value: "")
    let shouldLoadNextPage = BehaviorRelay(value: false)
    
    fileprivate let networkManager: Networkable?
    fileprivate let disposeBag = DisposeBag()
    fileprivate var currentPage = 1
    fileprivate var shouldShowLoadingNextPage = false
    
    // MARK - Initializer
    init() {
        self.networkManager = NetworkManager()
        self.bindSearchString()
        self.bindIsLoadingNextPage()
    }
    
    // MARK - Bindings
    fileprivate func bindSearchString() {
        searchString
        .filter{ $0.count > 3 }
        .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] text in
                guard let `self` = self,
                    text != "" else { return }
                self.clearResultsTable()
                self.searchMovies(by: text)
        }).disposed(by: disposeBag)
    }
    
    fileprivate func bindIsLoadingNextPage() {
        shouldLoadNextPage
            .debounce(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] value in
                guard let `self` = self,
                    self.shouldShowLoadingNextPage else { return }
                if value  { self.fetchNextPage() }
        }).disposed(by: disposeBag)
    }
    
    // MARK - Fetching
    fileprivate func fetchNextPage() {
        currentPage += 1
        searchMovies(by: searchString.value)
    }
    
    fileprivate func searchMovies(by text: String) {
        guard let networkManager = networkManager else { return }
        
        networkManager.getMoviesByQuery(string: text, from: currentPage)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let `self` = self else { return }
                switch (result) {
                case .success (let page):
                    self.setFetchedMovies(from: page)
                case .error (let error):
                    self.sendErrorMessage(text: Strings.TRY_AGAIN_ERR_TXT,
                                          name: String(describing: self),
                                          error: error)
                }
        }).disposed(by: disposeBag)
    }
    
    fileprivate func setFetchedMovies(from page: PagedResponse<MovieApi>) {
        guard let fetchedApiMovies = page.results,
            let currentPage = page.currentPage,
            let numberOfPages = page.numberOfPages
            else { return }
        
        fetchedApiMovies.forEach({ (movieApi) in
            let movie = movieApi.convert()
            if (!self.fetchedMovies.value.contains(movie)) {
                self.fetchedMovies.accept(self.fetchedMovies.value + [movie])
            }
        })
        
        self.shouldLoadNextPage.accept(false)
        self.shouldShowLoadingNextPage = currentPage < numberOfPages
    }
    
    func clearResultsTable() {
        currentPage = 1
        shouldShowLoadingNextPage = false
        fetchedMovies.accept([])
    }
    
}
