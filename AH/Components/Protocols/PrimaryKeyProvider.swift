//
//  PrimaryKeyProvider.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

protocol PrimaryKeyProvider {
    static var primaryKey: String { get }
}
