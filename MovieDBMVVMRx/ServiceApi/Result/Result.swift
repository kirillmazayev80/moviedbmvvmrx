//
//  Result.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/11/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

// result enum for api managers
enum Result<T> {
    case success(T)
    case error(Error)
}
