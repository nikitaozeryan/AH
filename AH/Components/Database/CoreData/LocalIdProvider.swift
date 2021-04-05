//
//  LocalIdProvider.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

protocol LocalIdProvider {
    static var localKey: String { get }
}
