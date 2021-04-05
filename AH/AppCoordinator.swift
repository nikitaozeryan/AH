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
    private(set) lazy var fetchPokemonsAction = Action(execute: fetchCollection)
    
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
        window.makeKeyAndVisible()
        fetchPokemonsAction.values.take(duringLifetimeOf: self).observe(on: UIScheduler()).observeValues { response in
            print("lalal")
        }
        fetchPokemonsAction.apply().start()
        
    }
    
    private func fetchCollection() -> AsyncTask<Void> {
        useCases.remoteData.fetchCollection(with: BaseParameters(language: .en, pagination: LimitOffset(page: 2, limit: 10), format: .json, sortParameter: .artist))
    }
}
