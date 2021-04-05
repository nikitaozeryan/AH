//
//  Collection+SafeAccess.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

extension Collection {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    func item(at index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
