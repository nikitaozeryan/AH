//
//  TimeInverval+AsString.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

extension TimeInterval {
    var asString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second, .nanosecond]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        formatter.maximumUnitCount = .zero
        return formatter.string(from: self)
    }
}
