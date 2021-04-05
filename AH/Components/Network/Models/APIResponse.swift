//
//  APIResponse.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

struct APIResponse<Value> {
    let data: Value

    func map<T>(_ transform: (Value) throws -> T) rethrows -> APIResponse<T> {
        let newData = try transform(data)
        return APIResponse<T>(data: newData)
    }
}

extension APIResponse: Decodable where Value: Decodable {}
