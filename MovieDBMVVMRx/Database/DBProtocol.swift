//
//  DBProtocol.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/15/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import RealmSwift

protocol DBProtocol {
    func hasAdded(by primaryKey: Int) -> Bool
    func fetch() -> Results<MovieRealm>? 
    func create(movie: Movie)
    func delete(primaryKey: Int)
}
