//
//  DbManager.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/15/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import RealmSwift

class DBManager: DBProtocol {
    
    // defines if movie has added into database
    func hasAdded(by primaryKey: Int) -> Bool {
        guard let realm = try? Realm() else { return false }
        if realm.object(ofType: MovieRealm.self, forPrimaryKey: primaryKey) != nil {
            return true
        } else {
            return false
        }
    }
    
    // fetch movie from database
    func fetch() -> Results<MovieRealm>? {
        guard let realm = try? Realm() else { return nil }
        let movieResults = realm.objects(MovieRealm.self)
        return movieResults
    }
    
    // create movie realm object & add it to database
    func create(movie: Movie) {
        guard let realm = try? Realm() else { return }
        let movieRealm = MovieRealm(from: movie)
        if realm.object(ofType: MovieRealm.self,
                        forPrimaryKey: movieRealm.id) == nil {
            do {
                try realm.write { realm.add(movieRealm, update: .all) }
            } catch {
                print("Realm add movie error")
            }
        }
    }
    
    // delete movie from database by primary key
    func delete(primaryKey: Int) {
        guard let realm = try? Realm(),
            let movieRealm = realm.object(ofType: MovieRealm.self, forPrimaryKey: primaryKey)
            else { return }
        do {
            try realm.write {
                if let overviewRealm = movieRealm.overviewRealm {
                    realm.delete(overviewRealm)
                }
                realm.delete(movieRealm)
            }
        } catch {
            print("Realm delete movie error")
        }
    }
    
}
