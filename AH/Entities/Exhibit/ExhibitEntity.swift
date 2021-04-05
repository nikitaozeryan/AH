//
//  ExhibitEntity.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//
//

import Foundation
import CoreData

@objc(ExhibitEntity)
public final class ExhibitEntity: NSManagedObject, FetchRequestProvider, ManagedObject {
    typealias ID = String
    
    @NSManaged public var id: String
    @NSManaged public var title: String
    @NSManaged public var painter: String
    @NSManaged public var longTitle: String
    @NSManaged public var image: ImageEntity?
}

// MARK: - PrimaryKeyProvider

extension ExhibitEntity: PrimaryKeyProvider {
    static var primaryKey: String {
        return #keyPath(ExhibitEntity.id)
    }
}
