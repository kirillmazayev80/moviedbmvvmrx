//
//  RequestError.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/11/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

// request errors by http status codes
enum RequestError {
    case reqErr300s
    case reqErr400
    case reqErr401
    case reqErr404
    case reqErr500s
    case reqErrUnknown
}
