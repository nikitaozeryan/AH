//
//  Exhibit.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

struct Exhibit {
    
    // MARK: - Properties
    
    let id: String
    let title: String
    let painter: String
    let image: Image?
    let description: String
    
    // MARK: - Lifecycle
    
    init(from cdObject: ExhibitEntity) {
        id = cdObject.id
        title = cdObject.title
        painter = cdObject.painter
        description = cdObject.longTitle
        image = cdObject.image.map(Image.init)
    }
}

// MARK: - CoreDataPersistable

extension Exhibit: CoreDataPersistable {
    typealias ManagedObject = ExhibitEntity
    
    var primaryKeyValue: Any {
        return id
    }
    
    func update(_ object: ManagedObject) throws {
        object.id = id
        object.title = title
        object.painter = painter
        object.longTitle = description
    }
}
