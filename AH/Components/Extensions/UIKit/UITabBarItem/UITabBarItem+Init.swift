//
//  UITabBarItem+Init.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import UIKit

extension UITabBarItem {
    convenience public init(title: String?, image: UIImage?) {
        self.init(title: title, image: image, selectedImage: image)
    }
}
