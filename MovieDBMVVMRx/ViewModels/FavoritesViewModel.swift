//
//  FavoritesViewModel.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/23/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import RxSwift
import RxCocoa
import RealmSwift

class FavoritesViewModel: Messagable {
    
    let sortedMovies = BehaviorRelay(value: [Movie]())
    var errorMessages = PublishSubject<String>()
    let sortingType = BehaviorRelay(value: 0)
    
    fileprivate var dbManager: DBProtocol?
    fileprivate var notificationToken: NotificationToken?
    fileprivate let disposeBag = DisposeBag()
    fileprivate var fetchedMovies = [Movie]()
    fileprivate enum FavoritesSort: Int {
        case title = 0
        case releaseDate = 1
        case rate = 2
    }
    
    init(dbManager: DBProtocol) {
        self.dbManager = dbManager
        self.fetchMovies()
        self.bindSortingType()
    }
    
    deinit {
        // notification invalidating
        if let notificationToken = self.notificationToken {
            notificationToken.invalidate()
        }
    }
    
    // Bindings
    fileprivate func bindSortingType() {
        sortingType.subscribe(onNext: { [weak self] type in
            guard let `self` = self else { return }
            self.insertSortedMovies()
        }).disposed(by: disposeBag)
    }
    
    // Fetching
    fileprivate func fetchMovies() {
        guard let dbManager = self.dbManager else { return }
        
        if let movieResults = dbManager.fetch() {
            notificationToken = movieResults.observe { [weak self] (changes: RealmCollectionChange) in
                    guard let `self` = self else { return }
                    switch (changes) {
                        case .initial:
                            movieResults.forEach({ movie in
                                self.fetchedMovies.append(movie.convert())
                            })
                        case .update(_, let deletions, let insertions, _):
                            insertions.forEach({ (index) in
                                let newMovie = movieResults[index].convert()
                                self.fetchedMovies.append(newMovie)
                            })
                            deletions.forEach({ (index) in
                                self.fetchedMovies.remove(at: index)
                            })
                        case .error (let error):
                            self.sendErrorMessage(text: Strings.CONTACT_SUPPORT_ERR_TXT,
                                                  name: String(describing: self),
                                                  error: error)
                        //return
                    }
                    self.insertSortedMovies()
            }
        }
    }
    
    fileprivate func insertSortedMovies() {
        let sortedMoviesNotEmpty = !sortedMovies.value.isEmpty
        if (sortedMoviesNotEmpty) {
            //sortedMovies.removeAll()
            sortedMovies.accept([])
        }
        var value = sortedMovies.value
        value.insert(contentsOf: sortingFavoritesByType(), at: 0)
        sortedMovies.accept(value)
    }
    
    fileprivate func sortingFavoritesByType() -> [Movie] {
        guard let sortingType = FavoritesSort(rawValue: sortingType.value) else { return [] }
        // return sorted fetched movies by sorting type
        switch (sortingType) {
        case .title:
            return fetchedMovies.sorted(by: { return $0.title < $1.title })
        case .releaseDate:
            return fetchedMovies.sorted(by: {
                guard let fstDate = $0.overview?.releaseDate.toDate(),
                    let secDate = $1.overview?.releaseDate.toDate()
                    else { return false }
                return fstDate > secDate })
        case .rate:
            return fetchedMovies.sorted(by: {
                guard let fstRate = $0.overview?.voteAverage,
                    let secRate = $1.overview?.voteAverage
                    else { return false }
                return fstRate > secRate
            })
        }
    }
    
}
