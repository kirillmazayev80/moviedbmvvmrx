//
//  ActorsListViewModel.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/23/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import RxSwift
import RxCocoa

class ActorsListViewModel: Messagable {
    
    let actors = BehaviorRelay(value: [Actor]())
    var errorMessages = PublishSubject<String>()
    let stopRefreshing = BehaviorRelay(value: false)
    let shouldLoadNextPage = BehaviorRelay(value: false)
    
    fileprivate let networkManager: Networkable?
    fileprivate let disposeBag = DisposeBag()
    fileprivate var currentPage = 1
    fileprivate var shouldShowLoadingNextPage = false
    
    // MARK - Initializer
    init() {
        self.networkManager = NetworkManager()
        self.bindIsLoadingNextPage()
        self.refreshMovies()
    }
    
    // MARK - Bindings
    fileprivate func bindIsLoadingNextPage() {
        shouldLoadNextPage.asObservable()
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
        loadMovies()
    }
    
    func refreshMovies() {
        currentPage = 1
        loadMovies(refresh: true)
    }
    
    fileprivate func loadMovies(refresh: Bool = false) {
        guard let networkManager = networkManager else { return }
        if refresh { stopRefreshing.accept(false) }
        networkManager.getActors(from: currentPage)
        .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let `self` = self else { return }
                switch (result) {
                case .success(let page):
                    self.setFetchedActors(from: page, withFlag: refresh)
                case .error(let error):
                    self.sendErrorMessage(text: Strings.TRY_AGAIN_ERR_TXT,
                                          name: String(describing: self),
                                          error: error)
                }
        }).disposed(by: disposeBag)
    }
    
    fileprivate func setFetchedActors(from page: PagedResponse<ActorApi>, withFlag refresh: Bool) {
        guard let fetchedApiActors = page.results,
            let currentPage = page.currentPage,
            let numberOfPages = page.numberOfPages
            else { return }
        
        let fetchedActors: [Actor] = fetchedApiActors.map{ $0.convert() }
        if refresh {
            self.actors.accept([])
            self.actors.accept(fetchedActors)
            self.stopRefreshing.accept(true)
        } else {
            fetchedActors.forEach({ (actor) in
                if (!self.actors.value.contains(actor)) {
                    self.actors.accept(self.actors.value + [actor])
                }
            })
        }
        self.shouldLoadNextPage.accept(false)
        self.shouldShowLoadingNextPage = currentPage < numberOfPages
    }
    
}
