//
//  Messagable.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/15/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import RxSwift

protocol Messagable {
    var errorMessages: PublishSubject<String> { get }
}

extension Messagable {
    
    func sendErrorMessage(text: String, name: String, error: Error) {
        self.errorMessages.onNext(text)
        print("\(name) ERROR: \(error.localizedDescription)")
    }
    
}
