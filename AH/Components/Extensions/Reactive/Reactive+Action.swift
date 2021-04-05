//
//  Reactive+Action.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import ReactiveSwift

extension Action {
    static func observedExecute(_ execute: @escaping (Input) -> SignalProducer<Output, Error>) -> Action {
        Action { params in
            execute(params).observe(on: UIScheduler())
        }
    }
}
