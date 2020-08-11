//
//  BioViewModel.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/23/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import RxSwift
import RxCocoa

class BioViewModel: Messagable {
    
    let bio = BehaviorRelay<Bio?>(value: nil)
    var errorMessages = PublishSubject<String>()
    
    fileprivate let networkManager: Networkable?
    fileprivate let disposeBag = DisposeBag()
    
    init(actorId: Int) {
        self.networkManager = NetworkManager()
        self.fetchBio(by: actorId)
    }
    
    func fetchBio(by id: Int) {
        guard let networkManager = networkManager else { return }
        networkManager.getBioBy(id: id)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let `self` = self else { return }
                switch (result) {
                    case .success(let bioApi):
                        self.bio.accept(bioApi.convert())
                    case .error(let error):
                        self.sendErrorMessage(text: Strings.TRY_AGAIN_ERR_TXT,
                                              name: String(describing: self),
                                              error: error)
                }
        }).disposed(by: disposeBag)
    }
    
}
