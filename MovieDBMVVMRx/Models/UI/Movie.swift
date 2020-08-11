//
//  Movie.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/11/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

struct Movie: Equatable {
    
    var id: Int
    var title: String
    var descr: String
    var posterPath: String?
    var backdropPath: String?
    var overview: Overview?
    
    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
    
}
