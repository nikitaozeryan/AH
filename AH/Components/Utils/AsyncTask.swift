//
//  DomainTask.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation
import ReactiveSwift

typealias AsyncTask<Value> = SignalProducer<Value, AppError>
