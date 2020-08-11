//
//  MovieRealm.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/15/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import Realm
import RealmSwift

class MovieRealm: Object {
    
    // Initialization
    convenience init(from: Movie) {
        self.init()
        self.id = from.id
        self.title = from.title
        self.descr = from.descr
        self.posterPath = from.posterPath ?? ""
        self.backdropPath = from.backdropPath ?? ""
        if let overview = from.overview {
            self.overviewRealm = OverviewRealm(from: overview)
        }
    }
    
    // Properties
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var descr: String = ""
    @objc dynamic var posterPath: String = ""
    @objc dynamic var backdropPath: String = ""
    @objc dynamic var overviewRealm: OverviewRealm?
    
    // Primary key
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // Functions
    func convert() -> Movie {
        return Movie(id: self.id,
                     title: self.title,
                     descr: self.descr,
                     posterPath: self.posterPath,
                     backdropPath: self.backdropPath,
                     overview: self.overviewRealm?.convert())
    }
    
}
