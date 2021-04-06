//
//  ExhibitDetailsEntity+CoreDataClass.swift
//  AH
//
//  Created by Nikita Ozerian on 06.04.2021.
//
//

import Foundation
import CoreData

@objc(ExhibitDetailsEntity)
public final class ExhibitDetailsEntity: NSManagedObject, FetchRequestProvider, ManagedObject {
    typealias ID = String
    
    @NSManaged public var id: String
    @NSManaged public var createdOn: String?
    @NSManaged public var updatedOn: String?
    @NSManaged public var productionPlaces: [String]
    @NSManaged public var materials: [String]
    @NSManaged public var presentingDate: String?
    @NSManaged public var period: Int64
    @NSManaged public var artist: String?
    @NSManaged public var techniques: [String]
}

// MARK: - PrimaryKeyProvider

extension ExhibitDetailsEntity: PrimaryKeyProvider {
    static var primaryKey: String {
        return #keyPath(ExhibitDetailsEntity.id)
    }
}
