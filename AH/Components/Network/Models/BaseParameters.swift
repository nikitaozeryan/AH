//
//  BaseParameters.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

class BaseParameters: RequestParams {
    let language: Language?
    let pagination: LimitOffset?
    let format: Format?
    let sortParameter: SortParameter?
    let imageOnly: Bool?
    var key: String {
        Bundle.main.object(forInfoDictionaryKey: "key") as? String ?? ""
    }
    
    required init(language: Language = .en,
                  pagination: LimitOffset?,
                  format: Format = .json,
                  sortParameter: SortParameter?,
                  imageOnly: Bool?) {
        
        self.language = language
        self.pagination = pagination
        self.format = format
        self.sortParameter = sortParameter
        self.imageOnly = imageOnly
    }
    
    var builder: Parameters {
        Parameters { parameters in
            parameters.key <- key
            
            pagination.flatMap {
                parameters.p <- $0.page
                parameters.ps <- $0.limit
            }
            
            imageOnly.flatMap {
                parameters.imgonly <- $0
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
