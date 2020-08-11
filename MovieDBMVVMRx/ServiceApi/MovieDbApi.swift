//
//  MovieDbApi.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/11/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import Moya

enum MovieDbApi {
    case getMovies(page: Int)
    case getMoviesByGenre(id: Int, page: Int)
    case getMoviesByQuery(string: String, page: Int)
    case getOverviewBy(id: Int)
    case getActors(page: Int)
    case getBioBy(id: Int)
    case getGenres
}


extension MovieDbApi: TargetType {
    
    var baseURL: URL { return URL(string: "https://api.themoviedb.org/3")! }
    var apiKey: String { return "22a70e0d4fabba8f679ec6f710d194fc"}
    
    var path: String {
        switch self {
            case .getMovies: return "/discover/movie"
            case .getMoviesByGenre(let id, _): return "/genre/\(id)/movies"
            case .getMoviesByQuery(_, _): return "/search/movie"
            case .getOverviewBy(let id): return "/movie/\(id)"
            case .getActors: return "/trending/person/week"
            case .getBioBy(let id): return "/person/\(id)"
            case .getGenres: return "/genre/movie/list"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .getMovies: return .get
            case .getMoviesByGenre: return .get
            case .getMoviesByQuery: return .get
            case .getOverviewBy: return .get
            case .getActors: return .get
            case .getBioBy: return .get
            case .getGenres: return .get
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
            case .getMovies(let page): return .requestParameters(parameters: ["api_key": apiKey, "page": page], encoding: URLEncoding.queryString)
            case .getMoviesByGenre( _, let page): return .requestParameters(parameters: ["api_key": apiKey, "page": page], encoding: URLEncoding.queryString)
            case .getMoviesByQuery(let string, let page): return .requestParameters(parameters: ["api_key": apiKey, "query": string, "page": page], encoding: URLEncoding.queryString)
            case .getOverviewBy: return .requestParameters(parameters: ["api_key": apiKey], encoding: URLEncoding.queryString)
            case .getActors(let page):  return .requestParameters(parameters: ["api_key": apiKey, "page": page], encoding: URLEncoding.queryString)
            case .getBioBy: return .requestParameters(parameters: ["api_key": apiKey], encoding: URLEncoding.queryString)
            case .getGenres: return .requestParameters(parameters: ["api_key": apiKey], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
}
