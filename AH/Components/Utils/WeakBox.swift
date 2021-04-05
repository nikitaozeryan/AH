//
//  WeakBox.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

public struct WeakBox<T: AnyObject> {
    public private(set) weak var value: T?
    public init(value: T) {
        self.value = value
    }
}
