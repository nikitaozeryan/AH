//
//  BaseParameters.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

struct BaseParameters: RequestParams {
    var language: Language?
    var pagination: LimitOffset?
    var format: Format?
    var sortParameter: SortParameter?
    var key: String {
        Bundle.main.object(forInfoDictionaryKey: "key") as? String ?? ""
    }
    
    var builder: Parameters {
        Parameters { parameters in
            parameters.key <- key
            
            pagination.flatMap {
                parameters.p <- $0.page
                parameters.ps <- $0.limit
            }
            
            format.flatMap {
                parameters.format <- $0.rawValue
            }
            
            sortParameter.flatMap {
                parameters.s <- $0.rawValue
            }
        }
    }
}
