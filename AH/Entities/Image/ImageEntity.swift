//
//  ImageEntity.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//
//

import Foundation
import CoreData

@objc(ImageEntity)
public final class ImageEntity: NSManagedObject, FetchRequestProvider, ManagedObject {
    typealias ID = String

    @NSManaged public var id: String
    @NSManaged public var width: Float
    @NSManaged public var height: Float
    @NSManaged public var url: String
    @NSManaged public var exhibit: ExhibitEntity
}

// MARK: - PrimaryKeyProvider

extension ImageEntity: PrimaryKeyProvider {
    static var primaryKey: String {
        return #keyPath(ImageEntity.id)
    }
}
