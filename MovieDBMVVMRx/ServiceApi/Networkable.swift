//
//  Networkable.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/11/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import Moya
import RxSwift

protocol Networkable {
    var provider: MoyaProvider<MovieDbApi> { get }
    func getMovies(from page: Int) -> Observable<Result<PagedResponse<MovieApi>>>
    func getMoviesByGenre(id: Int, from page: Int) -> Observable<Result<PagedResponse<MovieApi>>>
    func getMoviesByQuery(string: String, from page: Int) -> Observable<Result<PagedResponse<MovieApi>>>
    func getOverviewBy(id: Int) -> Observable<Result<OverviewApi>>
    func getActors(from page: Int) -> Observable<Result<PagedResponse<ActorApi>>>
    func getBioBy(id: Int) -> Observable<Result<BioApi>>
    func getGenres() -> Observable<Result<GenresListApi>>
}
