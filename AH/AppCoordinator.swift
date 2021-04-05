//
//  AppCoordinator.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import UIKit
import ReactiveSwift

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
        let navigationController = BaseNavigationVC()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
