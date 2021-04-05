//
//  UINavigationController+PopControllers.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import UIKit

extension UINavigationController {
    func popControllers(count: Int, animated: Bool = true) {
        guard viewControllers.count > count else { return }
        popToViewController(viewControllers[viewControllers.count - count - 1], animated: animated)
    }
}
