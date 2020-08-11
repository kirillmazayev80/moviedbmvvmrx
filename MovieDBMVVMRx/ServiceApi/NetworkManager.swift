//
//  NetworkManager.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/11/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import Moya
import RxSwift
import Alamofire

struct NetworkManager: Networkable {

    var provider = MoyaProvider<MovieDbApi>(plugins: [NetworkLoggerPlugin(verbose: true)])

    
    func getMovies(from page: Int) -> Observable<Result<PagedResponse<MovieApi>>> {
        return provider.rx.request(.getMovies(page: page))
            .asObservable()
            .map { response -> Result<PagedResponse<MovieApi>> in
                return self.handleResponse(type: PagedResponse<MovieApi>.self, from: response)
            }
    }
    
    func getMoviesByGenre(id: Int, from page: Int) -> Observable<Result<PagedResponse<MovieApi>>> {
        return provider.rx.request(.getMoviesByGenre(id: id, page: page))
            .asObservable()
            .map { response -> Result<PagedResponse<MovieApi>> in
                return self.handleResponse(type: PagedResponse<MovieApi>.self, from: response)
            }
    }
    
    func getMoviesByQuery(string: String, from page: Int) -> Observable<Result<PagedResponse<MovieApi>>> {
        return provider.rx.request(.getMoviesByQuery(string: string, page: page))
            .asObservable()
            .map { response -> Result<PagedResponse<MovieApi>> in
                return self.handleResponse(type: PagedResponse<MovieApi>.self, from: response)
        }
    }
    
    func getOverviewBy(id: Int) -> Observable<Result<OverviewApi>> {
        return provider.rx.request(.getOverviewBy(id: id))
            .asObservable()
            .map { response -> Result<OverviewApi> in
                return self.handleResponse(type: OverviewApi.self, from: response)
        }
    }
    
    func getActors(from page: Int) -> Observable<Result<PagedResponse<ActorApi>>> {
        return provider.rx.request(.getActors(page: page))
            .asObservable()
            .map { response -> Result<PagedResponse<ActorApi>> in
                return self.handleResponse(type: PagedResponse<ActorApi>.self, from: response)
        }
    }
    
    func getBioBy(id: Int) -> Observable<Result<BioApi>> {
        return provider.rx.request(.getBioBy(id: id))
            .asObservable()
            .map { response -> Result<BioApi> in
                return self.handleResponse(type: BioApi.self, from: response)
        }
    }
    
    func getGenres() -> Observable<Result<GenresListApi>> {
        return provider.rx.request(.getGenres)
            .asObservable()
            .map { response -> Result<GenresListApi> in
                return self.handleResponse(type: GenresListApi.self, from: response)
        }
    }
    
    // handling response for proper api model
    func handleResponse<T: Decodable>(type: T.Type, from response: Response) -> Result<T>  {
        switch response.statusCode {
            case 200...299:
                do {
                    let model = try JSONDecoder().decode(T.self, from: response.data)
                    return .success(model)
                } catch {
                    return .error(FetchError.parseError)
                }
            case 300...399: return .error(FetchError.requestError(value: .reqErr300s))
            case 400: return .error(FetchError.requestError(value: .reqErr400))
            case 401: return .error(FetchError.requestError(value: .reqErr401))
            case 404: return .error(FetchError.requestError(value: .reqErr404))
            case 500...599: return .error(FetchError.requestError(value: .reqErr500s))
            default : return .error(FetchError.requestError(value: .reqErrUnknown))
        }
    }
    
}
