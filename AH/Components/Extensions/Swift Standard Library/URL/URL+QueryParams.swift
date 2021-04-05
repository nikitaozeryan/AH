//
//  File.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

extension URL {
    
    func appending(_ params: [String: String]) -> URL {
        
        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
        
        var queryItems = urlComponents.queryItems ??  []
        queryItems += params.map { URLQueryItem(name: $0.key, value: $0.value) }
        urlComponents.queryItems = queryItems
        
        return urlComponents.url ?? self
        
    }
}
