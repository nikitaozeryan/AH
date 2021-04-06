//
//  Dating+Response.swift
//  AH
//
//  Created by Nikita Ozerian on 06.04.2021.
//

import Foundation

extension Dating {
    struct Response: Decodable {
        let presentingDate: String?
        let period: Int64?
    }
    
    // MARK: - Lifecycle
    
    init?(response: Response) {
        guard let date = response.presentingDate, let period = response.period else { return nil }
        presentingDate = date
        self.period = period
    }
}
