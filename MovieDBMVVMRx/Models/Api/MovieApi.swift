//
//  MovieApi.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/11/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

struct MovieApi: Decodable {
    
    var id: Int = 0
    var title: String = ""
    var descr: String = ""
    var posterPath: String?
    var backdropPath: String?
    var overviewApi: OverviewApi?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case descr = "overview"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        do { self.id = try valueContainer.decode(Int.self, forKey: .id) } catch { print("json decode err: movie id") }
        do { self.title = try valueContainer.decode(String.self, forKey: .title) } catch { print("json decode err: title") }
        do { self.descr = try valueContainer.decode(String.self, forKey: .descr) } catch { print("json decode err: descr") }
        do { self.posterPath = try valueContainer.decode(String.self, forKey: .posterPath) } catch { print("json decode err: poster path")}
        do { self.backdropPath = try valueContainer.decode(String.self, forKey: .backdropPath) } catch { print("json decode err: backdrop path") }
    }
    
    func convert() -> Movie {
        return Movie(id: self.id,
                     title: self.title,
                     descr: self.descr,
                     posterPath: self.posterPath,
                     backdropPath: self.backdropPath,
                     overview:  (self.overviewApi != nil ? self.overviewApi?.convert() : nil)
        )
    }
    
}
