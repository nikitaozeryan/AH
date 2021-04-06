//
//  MuseumCollectionCoordinator.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import ReactiveSwift
import UIKit

final class MuseumCollectionCoordinator: Coordinator {
    
    // MARK: - Public Properties
    
    let useCases: UseCasesProvider
    
    // MARK: - Private properties
    
    private lazy var factory = MuseumCollectionFactory(coordinator: self)
    private weak var navigationController: UINavigationController!
    
    // MARK: - Life Cycle
    
    init(navigationController: UINavigationController,
         useCases: UseCasesProvider) {
        self.useCases = useCases
        self.navigationController = navigationController
    }
    
    func start(animated: Bool = true) {
        let collectionVC = factory.makeCollectionVC(delegate: self)
        navigationController.setViewControllers([collectionVC], animated: animated)
    }
    
    func stop(animated: Bool = true) {
        navigationController.popViewController(animated: true)
    }
}

// MARK: - CollectionVMDelegate

extension MuseumCollectionCoordinator: CollectionVMDelegate {
    func collectionVM(_ viewModel: CollectionVM, didSelectExhibit exhibit: ExhibitWithDetails) {
        print(exhibit)
    }
}
