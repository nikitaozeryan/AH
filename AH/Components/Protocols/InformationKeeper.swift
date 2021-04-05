//
//  InformationKeeper.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

protocol InformationKeeper {
    associatedtype Info: Codable

    func save(_ info: Info) throws
    func invalidate() throws
    func fetch() -> Info?
}
