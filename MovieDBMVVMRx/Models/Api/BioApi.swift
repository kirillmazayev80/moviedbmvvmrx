//
//  BioApi.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/23/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

struct BioApi: Decodable {
    
    var id: Int = 0
    var name: String = ""
    var birthday: String = ""
    var gender: Int = 1
    var biography: String = ""
    var popularity: Double = 0.0
    var placeOfBirth: String = ""
    var profilePath: String?
    var homepage: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case birthday
        case gender
        case biography
        case popularity
        case placeOfBirth = "place_of_birth"
        case profilePath = "profile_path"
        case homepage
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { self.id = try container.decode(Int.self, forKey: .id) } catch {}
        do { self.name = try container.decode(String.self, forKey: .name) } catch {}
        do { self.birthday = try container.decode(String.self, forKey: .birthday) } catch {}
        do { self.gender = try container.decode(Int.self, forKey: .gender) } catch {}
        do { self.biography = try container.decode(String.self, forKey: .biography) } catch {}
        do { self.popularity = try container.decode(Double.self, forKey: .popularity) } catch {}
        do { self.placeOfBirth = try container.decode(String.self, forKey: .placeOfBirth) } catch {}
        do { self.profilePath = try container.decode(String.self, forKey: .profilePath) } catch {}
        do { self.homepage = try container.decode(String.self, forKey: .homepage) } catch {}
    }
    
    func convert() -> Bio {
        return Bio(id: self.id, name: self.name, birthday: self.birthday, gender: self.gender, biography: self.biography, popularity: self.popularity, placeOfBirth: self.placeOfBirth, profilePath: self.profilePath, homepage: self.homepage)
    }
    
}
