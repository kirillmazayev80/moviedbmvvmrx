//
//  MoviesViewModel.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/11/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import RxSwift
import RxCocoa

class MoviesViewModel: Messagable {
    
    var fetchedMovies = BehaviorRelay(value: [Movie]())
    let fetchingMoviesType = BehaviorRelay(value: 0)
    let shouldLoadNextPage = BehaviorRelay(value: false)
    var stopRefreshing = BehaviorRelay(value: false)
    var errorMessages = PublishSubject<String>()
    
    fileprivate let networkManager: Networkable?
    fileprivate let disposeBag = DisposeBag()
    fileprivate var currentPage = 1
    fileprivate var shouldShowLoadingNextPage = false
    
    // MARK - Initializer
    init() {
        self.networkManager = NetworkManager()
        self.bindFetchingMoviesType()
        self.bindShouldLoadNextPage()
    }
    
    // MARK - Bindings
    fileprivate func bindFetchingMoviesType() {
        fetchingMoviesType.asObservable()
        .distinctUntilChanged()
            .subscribe { [weak self] (event) in
                guard let `self` = self else { return }
                self.refreshMovies()
        }.disposed(by: disposeBag)
    }
    
    fileprivate func bindShouldLoadNextPage() {
        shouldLoadNextPage.asObservable()
            .debounce(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] (value) in
                guard let `self` = self else { return }
                guard self.shouldShowLoadingNextPage else { return }
                if value  { self.fetchNextPage() }
        }).disposed(by: disposeBag)
    }
    
    fileprivate func loadMovies(refresh: Bool = false) {
        let genreId = UserDefaults.standard.integer(forKey: Utils.GENRE_ID)
        print("Genre = \(genreId)")
        switch (fetchingMoviesType.value) {
            case 0: loadMovies(refresh: refresh, genreId: nil)
            case 1: loadMovies(refresh: refresh, genreId: genreId)
            default: break
        }
    }
    
    
    // MARK - Fetching
    fileprivate func fetchNextPage() {
        currentPage += 1
        loadMovies()
    }
    
    func refreshMovies() {
        currentPage = 1
        loadMovies(refresh: true)
    }
    
    fileprivate func loadMovies(refresh: Bool, genreId: Int?) {
        guard let networkManager = networkManager else { return }
        if refresh { stopRefreshing.accept(false) }
        if (genreId != nil) {
            networkManager.getMoviesByGenre(id: genreId!, from: currentPage)
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [weak self] result in
                    guard let `self` = self else { return }
                    switch result {
                        case .success(let page):
                            self.setFetchedMovies(from: page, withFlag: refresh)
                        case .error(let error):
                            self.sendErrorMessage(text: Strings.TRY_AGAIN_ERR_TXT,
                                                  name: String(describing: self),
                                                  error: error)
                    }
                }).disposed(by: disposeBag)
        } else {
            networkManager.getMovies(from: currentPage)
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [weak self] result in
                    guard let `self` = self else { return }
                    switch result {
                        case .success(let page):
                            self.setFetchedMovies(from: page, withFlag: refresh)
                        case .error(let error):
                            self.sendErrorMessage(text: Strings.TRY_AGAIN_ERR_TXT,
                                                  name: String(describing: self),
                                                  error: error)
                    }
                }).disposed(by: disposeBag)
        }
    }
    
    fileprivate func setFetchedMovies(from page: PagedResponse<MovieApi>, withFlag refresh: Bool) {
        guard let fetchedApiMovies = page.results,
            let currentPage = page.currentPage,
            let numberOfPages = page.numberOfPages
            else { return }
        let fetchedMovies: [Movie] = fetchedApiMovies.map{ $0.convert() }
        if refresh {
            self.fetchedMovies.accept([])
            self.fetchedMovies.accept(fetchedMovies)
            self.stopRefreshing.accept(true)
        } else {
            fetchedMovies.forEach({ (movie) in
                if (!self.fetchedMovies.value.contains(movie)) {
                    self.fetchedMovies.accept(self.fetchedMovies.value + [movie])
                }
            })
        }
        self.shouldLoadNextPage.accept(false)
        self.shouldShowLoadingNextPage = currentPage < numberOfPages
    }
    
}
