//
//  Actor.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/23/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

struct Actor: Equatable {
    
    var id: Int
    var name: String
    var gender: Int
    var popularity: Double
    var profilePath: String?
    
    static func ==(lhs: Actor, rhs: Actor) -> Bool {
        return lhs.id == rhs.id
    }
    
}
