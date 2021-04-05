//
//  ApiErrorStatus.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

extension APIError {
    enum Status {
        case unauthorized
        case paymentRequired
        case forbidden
        case notFound
        case methodNotAllowed
        case notAcceptable
        case requestTimeout
        case unprocessable
        case serverError
        case other
    }
}
