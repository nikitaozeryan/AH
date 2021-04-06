//
//  Exhibit+Response.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

extension Exhibit {
    struct Response: Decodable {
        
        // MARK: - CodingKeys
        
        enum CodingKeys: String, CodingKey {
            case id
            case title
            case painter = "principalOrFirstMaker"
            case image = "webImage"
            case description = "longTitle"
            case objectNumber
        }
        
        // MARK: - Properties
        
        let id: String
        let title: String
        let painter: String
        let image: Image.Response?
        let description: String
        let objectNumber: String
        
        // MARK: - Lifecycle
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
            title = try container.decode(String.self, forKey: .title)
            painter = try container.decode(String.self, forKey: .painter)
            image = try container.decodeIfPresent(Image.Response.self, forKey: .image)
            description = try container.decode(String.self, forKey: .description)
            objectNumber = try container.decode(String.self, forKey: .objectNumber)
        }
    }
    
    // MARK: - Lifecycle
    
    init(response: Response) {
        id = response.id
        title = response.title
        painter = response.painter
        image = response.image.flatMap { Image(response: $0) }
        description = response.description
        objectNumber = response.objectNumber
    }
}
