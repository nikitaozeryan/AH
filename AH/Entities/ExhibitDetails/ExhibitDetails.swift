//
//  ExhibitDetails.swift
//  AH
//
//  Created by Nikita Ozerian on 06.04.2021.
//

import Foundation

struct ExhibitDetails {
    
    // MARK: - Properties
    
    let id: String
    let objectNumber: String
    let createdOn: String?
    let updatedOn: String?
    let productionPlaces: [String]
    let materials: [String]
    let dating: Dating?
    let artist: String?
    let techniques: [String]
    
    // MARK: - Lifecycle
    
    init(from cdObject: ExhibitDetailsEntity) {
        id = cdObject.id
        objectNumber = cdObject.objectNumber
        createdOn = cdObject.createdOn
        updatedOn = cdObject.updatedOn
        productionPlaces = cdObject.productionPlaces
        materials = cdObject.materials
        artist = cdObject.artist
        techniques = cdObject.techniques
        dating = cdObject.presentingDate.flatMap { Dating(presentingDate: $0, period: cdObject.period) }
    }
}

// MARK: - CoreDataPersistable

extension ExhibitDetails: CoreDataPersistable {
    typealias ManagedObject = ExhibitDetailsEntity
    
    var primaryKeyValue: Any {
        return objectNumber
    }
    
    func update(_ object: ManagedObject) throws {
        object.id = id
        object.objectNumber = objectNumber
        object.createdOn = createdOn
        object.updatedOn = updatedOn
        object.productionPlaces = productionPlaces
        object.materials = materials
        object.artist = artist
        object.presentingDate = dating?.presentingDate
        object.period = dating?.period ?? 0
        object.techniques = techniques
    }
}
