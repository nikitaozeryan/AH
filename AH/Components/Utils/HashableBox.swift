//
//  HashableBox.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

public struct HashableBox<Value>: Hashable {
    public typealias Builder = (inout Hasher, Value) -> Void
    public let value: Value

    private let builder: Builder

    public init(_ value: Value, builder: @escaping Builder) {
        self.value = value
        self.builder = builder
    }

    public func hash(into hasher: inout Hasher) {
        builder(&hasher, value)
    }

    public static func == (lhs: HashableBox, rhs: HashableBox) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
