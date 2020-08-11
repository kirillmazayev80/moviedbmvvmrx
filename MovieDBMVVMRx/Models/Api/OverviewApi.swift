//
//  OverviewApi.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/11/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

struct OverviewApi: Decodable {
    
    var id: Int = 0
    var title: String = ""
    var posterPath: String? = nil
    var overview: String = ""
    var releaseDate: String = ""
    var voteCount: Int = 0
    var popularity: Double = 0.0
    var voteAverage: Double = 0.0
    var budget: Int = 0
    var originalLang: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case voteCount = "vote_count"
        case popularity
        case voteAverage = "vote_average"
        case budget
        case originalLang = "original_language"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { self.id = try container.decode(Int.self, forKey: .id) } catch {}
        do { self.title = try container.decode(String.self, forKey: .title) } catch {}
        do { self.posterPath = try container.decode(String.self, forKey: .posterPath) } catch {}
        do { self.overview = try container.decode(String.self, forKey: .overview) } catch {}
        do { self.releaseDate = try container.decode(String.self, forKey: .releaseDate) } catch {}
        do { self.voteCount = try container.decode(Int.self, forKey: .voteCount) } catch {}
        do { self.popularity = try container.decode(Double.self, forKey: .popularity) } catch {}
        do { self.voteAverage = try container.decode(Double.self, forKey: .voteAverage) } catch {}
        do { self.budget = try container.decode(Int.self, forKey: .budget) } catch {}
        do { self.originalLang = try container.decode(String.self, forKey: .originalLang) } catch {}
    }
    
    func convert() -> Overview {
        return Overview(id: self.id, title: self.title, posterPath: self.posterPath, overview: self.overview, releaseDate: self.releaseDate, voteCount: self.voteCount, popularity: self.popularity, voteAverage: self.voteAverage, budget: self.budget, originalLang: self.originalLang)
    }
}
