//
//  Coordinator.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

protocol Coordinator: class {
    var useCases: UseCasesProvider { get }
    
    func start(animated: Bool)
    func stop(animated: Bool)
}
