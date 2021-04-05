//
//  CollectionResponse.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

struct CollectionResponse: Decodable {
    
    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        case exhibits = "artObjects"
        case count
    }
    
    // MARK: - Properties
    
    let exhibits: [Exhibit]
    let count: Int
    
    // MARK: - Lifecycle
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        exhibits = try container.decode([Exhibit.Response].self, forKey: .exhibits).compactMap(Exhibit.init)
        count = try container.decode(Int.self, forKey: .count)
    }
}
