//
//  RequestConvertibleProxy.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

struct CachedRequestConvertible: RequestConvertible {
    let baseURL: URL?
    let path: String
    let method: Network.Method
    let task: Network.Task
    let headers: Network.Headers?
    let retryEnabled: Bool

    init(_ target: RequestConvertible) {
        self.baseURL = target.baseURL
        self.path = target.path
        self.method = target.method
        self.task = target.task
        self.headers = target.headers
        self.retryEnabled = target.retryEnabled
    }
    
}
