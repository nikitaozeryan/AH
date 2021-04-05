//
//  Network+Headers.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

extension Network.Header {
    static func accept(contentTypes: [String]) -> Network.Header {
        return Network.Header(name: "Accept", value: contentTypes.joined(separator: ", "))
    }
    
    static var defaultAccept: Network.Header {
        return accept(contentTypes: ["application/json"])
    }
}
