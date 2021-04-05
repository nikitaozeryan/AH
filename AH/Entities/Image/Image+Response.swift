//
//  Image+Response.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import UIKit

extension Image {
    struct Response: Decodable {
        
        // MARK: - Properties
        
        var guid: String?
        var width: CGFloat?
        var height: CGFloat?
        var url: String?
    }
    
    // MARK: - Lifecycle
    
    init?(response: Response) {
        guard let id = response.guid,
              !id.isEmpty,
              let url = response.url,
              !url.isEmpty else { return nil }
        self.id = id
        width = response.width ?? 1
        height = response.height ?? 1
        self.url = url
    }
}
