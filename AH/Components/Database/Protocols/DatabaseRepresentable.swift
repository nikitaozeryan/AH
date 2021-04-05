//
//  DatabaseRepresentable.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

protocol DatabaseRepresentable: Identifiable {
    associatedtype ManagedObject
    associatedtype Context

    init(_ object: ManagedObject, context: Context) throws
}

extension DatabaseRepresentable where Context == Void {
    init(_ object: ManagedObject) throws {
        try self.init(object, context: ())
    }
}
