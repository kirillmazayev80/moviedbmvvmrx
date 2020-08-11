//
//  OverviewModel.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/14/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import RxSwift
import RxCocoa

class OverviewViewModel: Messagable {
    
    fileprivate let networkManager: Networkable?
    fileprivate let dbManager: DBProtocol?
    fileprivate let disposeBag = DisposeBag()
    let movie: Movie?
    
    // bindable values
    var overview = BehaviorRelay<Overview?>(value: nil)
    var hasAdded = BehaviorRelay(value: false)
    var errorMessages = PublishSubject<String>()
    
    init(movie: Movie) {
        self.networkManager = NetworkManager()
        self.dbManager = DBManager()
        self.movie = movie
        self.hasAdded.accept(dbManager?.hasAdded(by: movie.id) ?? false)
        self.fetchOverview(by: movie.id)
    }
    
    func fetchOverview(by id: Int) {
        guard let networkManager = networkManager else { return }
        networkManager.getOverviewBy(id: id)
            .subscribe(onNext: { [weak self] result in
                guard let `self` = self else { return }
                switch result {
                    case .success(let overview):
                        self.overview.accept(overview.convert())
                    case .error(let error):
                        self.sendErrorMessage(text: Strings.TRY_AGAIN_ERR_TXT,
                                              name: String(describing: self),
                                              error: error)
                }
            }).disposed(by: disposeBag)
    }
    
    func isAdded() {
        guard let dbManager = self.dbManager, let id = movie?.id else { return }
        self.hasAdded.accept(dbManager.hasAdded(by: id))
    }
    
    func onAddMovie() {
        guard let dbManager = self.dbManager,
            var movie = self.movie else { return }
        movie.overview = overview.value
        dbManager.create(movie: movie)
    }
    
    func onRemoveMovie() {
        guard let dbManager = dbManager,
            let movie = self.movie else { return }
        dbManager.delete(primaryKey: movie.id)
    }
}
