//
//  Result+Extension.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

extension Result {
    var value: Success? {
        switch self {
        case let .success(value): return value
        case .failure: return nil
        }
    }
    
    var error: Failure? {
        switch self {
        case .success: return nil
        case let .failure(error): return error
        }
    }
}
