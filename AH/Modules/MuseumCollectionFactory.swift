//
//  MuseumCollectionFactory.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

protocol MuseumCollectionFactoryProtocol {
    func makeCollectionVC(delegate: CollectionVMDelegate) -> CollectionVC
}

final class MuseumCollectionFactory: ModuleFactory, MuseumCollectionFactoryProtocol {
    func makeCollectionVC(delegate: CollectionVMDelegate) -> CollectionVC {
        makeController { $0.viewModel = CollectionVM(useCases: useCases, delegate: delegate) }
    }
}
