//
//  AppCoordinator.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import UIKit
import ReactiveSwift
import Bagel

final class AppCoordinator {
    
    // MARK: - Properties
    
    let window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
    
    private let useCases: UseCasesProvider
    private let (lifetime, token) = Lifetime.make()
    
    // MARK: - Setup
    init(useCases: UseCasesProvider) {
        self.useCases = useCases
        
        setup()
    }
    
    private func setup() {
        #if DEBUG
        Bagel.start()
        #endif
        let navigationController = BaseNavigationVC()
        window.rootViewController = navigationController
        let coordinator = MuseumCollectionCoordinator(navigationController: navigationController,
                                             useCases: useCases)
        coordinator.start()
        window.makeKeyAndVisible()
    }
}
