//
//  Reactive+UIApplication.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

extension Reactive where Base: UIApplication {
    var didEnterBackground: Signal<(), Never> {
        return NotificationCenter.default.reactive
            .notifications(forName: UIApplication.didEnterBackgroundNotification).map(value: ())
    }
    var willEnterForeground: Signal<(), Never> {
        return NotificationCenter.default.reactive
            .notifications(forName: UIApplication.willEnterForegroundNotification).map(value: ())
    }
    var didFinishLaunching: Signal<(), Never> {
        return NotificationCenter.default.reactive
            .notifications(forName: UIApplication.didFinishLaunchingNotification).map(value: ())
    }
    var didBecomeActive: Signal<(), Never> {
        return NotificationCenter.default.reactive
            .notifications(forName: UIApplication.didBecomeActiveNotification).map(value: ())
    }
    var willResignActive: Signal<(), Never> {
        return NotificationCenter.default.reactive
            .notifications(forName: UIApplication.willResignActiveNotification).map(value: ())
    }
}
