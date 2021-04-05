//
//  APIResponse.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

struct APIPageResponse<Value> {
    let results: Value
    let count: Int?
}

extension APIPageResponse: Decodable where Value: Decodable {}
