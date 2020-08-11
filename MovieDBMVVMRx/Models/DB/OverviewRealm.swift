//
//  OverviewRealm.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/15/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import Realm
import RealmSwift

class OverviewRealm: Object {
    
    // Initialization
    convenience init(from: Overview) {
        self.init()
        self.id = from.id
        self.title = from.title
        self.posterPath = from.posterPath ?? ""
        self.overview = from.overview
        self.releaseDate = from.releaseDate
        self.voteCount = from.voteCount
        self.popularity = from.popularity
        self.voteAverage = from.voteAverage
        self.budget = from.budget
        self.originalLang = from.originalLang
    }
    
    // Properties
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var posterPath: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var voteCount: Int = 0
    @objc dynamic var popularity: Double = 0
    @objc dynamic var voteAverage: Double = 0
    @objc dynamic var budget: Int = 0
    @objc dynamic var originalLang: String = ""
    
    // Primary key
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // Functions
    func convert() -> Overview {
        return Overview(id: self.id,
                        title: self.title,
                        posterPath: self.posterPath,
                        overview: self.overview,
                        releaseDate: self.releaseDate,
                        voteCount: self.voteCount,
                        popularity: self.popularity,
                        voteAverage: self.voteAverage,
                        budget: self.budget,
                        originalLang: self.originalLang
        )
    }
    
}
