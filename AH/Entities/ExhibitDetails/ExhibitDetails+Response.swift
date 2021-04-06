//
//  ExhibitDetails+Response.swift
//  AH
//
//  Created by Nikita Ozerian on 06.04.2021.
//

import Foundation

extension ExhibitDetails {
    struct Response: Decodable {
        
        // MARK: - CodingKeys
        
        enum CodingKeys: String, CodingKey {
            case page = "artObjectPage"
            case art = "artObject"
        }
        
        // MARK: - Properties
        
        let art: Art.Response
        let artPage: ArtPage
        
        // MARK: - Lifecycle
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            art = try container.decode(Art.Response.self, forKey: .art)
            artPage = try container.decode(ArtPage.self, forKey: .page)
        }
    }
    
    // MARK: - Lifecycle
    
    init(response: Response) {
        id = response.artPage.id
        createdOn = response.artPage.createdOn.flatMap { $0 == "0001-01-01T00:00:00" ? nil : $0 }
        updatedOn = response.artPage.updatedOn.flatMap { $0 == "0001-01-01T00:00:00" ? nil : $0 }
        let art = Art(response: response.art)
        productionPlaces = art.productionPlaces
        materials = art.materials
        dating = art.dating
        artist = art.artist
        techniques = art.techniques
    }
}
