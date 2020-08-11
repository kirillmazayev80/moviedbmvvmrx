//
//  ActorApi.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/23/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

struct ActorApi: Decodable {
    
    var id: Int = 0
    var name: String = ""
    var gender: Int = 2
    var popularity: Double = 0.0
    var profilePath: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case gender
        case popularity
        case profilePath = "profile_path"
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        do { self.id = try valueContainer.decode(Int.self, forKey: .id) } catch { print("json decode err: actor id") }
        do { self.name = try valueContainer.decode(String.self, forKey: .name) } catch { print("json decode err: actor name") }
        do { self.gender = try valueContainer.decode(Int.self, forKey: .gender) } catch { print("json decode err: actor gender") }
        do { self.popularity = try valueContainer.decode(Double.self, forKey: .popularity) } catch { print("json decode err: actor popularity")}
        do { self.profilePath = try valueContainer.decode(String.self, forKey: .profilePath) } catch { print("json decode err: actor profile path") }
    }
    
    func convert() -> Actor {
        return Actor(id: self.id,
                     name: self.name,
                     gender: self.gender,
                     popularity: self.popularity,
                     profilePath: self.profilePath
        )
    }
    
}
