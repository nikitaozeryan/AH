//
//  AnyEncodable.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

struct AnyEncodable: Encodable {
    let encodable: Encodable

    func encode(to encoder: Encoder) throws {
        try encodable.encode(to: encoder)
    }
}
