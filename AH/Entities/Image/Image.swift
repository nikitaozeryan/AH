//
//  Image.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import UIKit

struct Image {
    
    // MARK: - Properties
    
    var id: String
    var width: CGFloat
    var height: CGFloat
    var url: String
    
    // MARK: - Lifecycle
    
    init(from cdObject: ImageEntity) {
        id = cdObject.id
        height = CGFloat(cdObject.height)
        width = CGFloat(cdObject.width)
        url = cdObject.url
    }
}

// MARK: - CoreDataPersistable

extension Image: CoreDataPersistable {
    typealias ManagedObject = ImageEntity
    
    var primaryKeyValue: Any {
        return id
    }
    
    func update(_ object: ManagedObject) throws {
        object.id = id
        object.height = Float(height)
        object.width = Float(width)
        object.url = url
    }
}
