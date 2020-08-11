//
//  SelectGenreSettingsViewModel.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/23/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import RxSwift
import RxCocoa

class SelectGenreSettingsViewModel: Messagable {
    
    let genres = BehaviorRelay(value: [Genre]())
    let genreHasChanged = BehaviorRelay(value: false)
    var errorMessages = PublishSubject<String>()
    
    fileprivate let networkManager: Networkable?
    fileprivate let disposeBag = DisposeBag()
    
    init() {
        self.networkManager = NetworkManager()
        self.fetchGenres()
    }
    
    func fetchGenres() {
        guard let networkManager = networkManager else { return }
        networkManager.getGenres()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let `self` = self else { return }
                switch (result) {
                case .success(let genresApiList):
                    guard let genresApi = genresApiList.genresApi else { return }
                    let genres = genresApi.compactMap { $0.convert() }
                    self.genres.accept(genres)
                case .error(let error):
                    self.sendErrorMessage(text: Strings.TRY_AGAIN_ERR_TXT,
                                          name: String(describing: self),
                                          error: error)
                }
            }).disposed(by: disposeBag)
    }
    
    func storeGenre(_ genre: Genre) {
        UserDefaults.standard.set(genre.id, forKey: Utils.GENRE_ID)
        UserDefaults.standard.set(genre.name, forKey: Utils.GENRE_NAME)
    }
    
}
