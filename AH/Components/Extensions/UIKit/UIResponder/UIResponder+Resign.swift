//
//  UIResponder+Resign.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import UIKit

extension UIResponder {
    @objc static func resignFirstResponder() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
