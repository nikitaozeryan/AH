//
//  Int+KFormatted.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

extension Int {
    func kFormatted() -> String {
        guard (self / 1000) >= 1 else { return "\(self)" }
        return self >= 1000000 ? "\(self / 1000000)m" : "\(self / 1000)k"
    }
    
    var isZero: Bool {
        self == .zero
    }
}
