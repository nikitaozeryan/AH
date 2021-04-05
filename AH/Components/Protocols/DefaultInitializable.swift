//
//  DefaultInitializable.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

protocol DefaultInitializable: Makeable {
    init()
}

extension DefaultInitializable where Value == Self {
    static func make() -> Value {
        return Self()
    }
}
