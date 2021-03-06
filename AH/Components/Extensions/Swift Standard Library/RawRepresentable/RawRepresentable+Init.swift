//
//  RawRepresentable+Init.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

extension RawRepresentable {
    init(trying rawValue: RawValue) throws {
        guard let value = Self(rawValue: rawValue) else {
            throw RawRepresentableError(type: Self.self, rawValue: rawValue)
        }
        self = value
    }
}

struct RawRepresentableError: LocalizedError {
    let type: Any
    let rawValue: Any

    var errorDescription: String? {
        return "Could not init '\(type)' with '\(rawValue)'"
    }
}
