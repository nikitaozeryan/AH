//
//  DatabaseError.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

enum DatabaseError: LocalizedError {
    case notFound(type: Any, id: Any)
}
