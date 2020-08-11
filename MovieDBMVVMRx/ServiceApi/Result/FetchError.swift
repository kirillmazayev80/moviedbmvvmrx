//
//  FetchError.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/11/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

// fetch error for api request result
enum FetchError: Error {
    case requestError(value: RequestError)
    case parseError
    case malformedRequest
}
