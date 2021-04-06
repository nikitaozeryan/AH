//
//  Art+Response.swift
//  AH
//
//  Created by Nikita Ozerian on 06.04.2021.
//

import Foundation

extension Art {
    struct Response: Decodable {
        // MARK: - CodingKeys
        
        enum CodingKeys: String, CodingKey {
            case places = "productionPlaces"
            case materials
            case dating
            case artist = "principalOrFirstMaker"
            case techniques
        }
        
        // MARK: - Properties
        
        let productionPlaces: [String]
        let materials: [String]
        let dating: Dating.Response?
        let artist: String?
        let techniques: [String]
        
        // MARK: - Lifecycle
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            productionPlaces = try container.decode([String].self, forKey: .places)
            materials = try container.decode([String].self, forKey: .places)
            dating = try container.decodeIfPresent(Dating.Response.self, forKey: .dating)
            artist = try container.decodeIfPresent(String.self, forKey: .artist)
            techniques = try container.decode([String].self, forKey: .techniques)
        }
    }
    
    // MARK: - Lifecycle
    
    init(response: Response) {
        productionPlaces = response.productionPlaces
        materials = response.materials
        dating = response.dating.flatMap(Dating.init)
        artist = response.artist
        techniques = response.techniques
    }
}
