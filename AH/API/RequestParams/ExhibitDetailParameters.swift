//
//  ExhibitDetailParameters.swift
//  AH
//
//  Created by Nikita Ozerian on 06.04.2021.
//

import Foundation

final class ExhibitDetailParameters: BaseParameters {
    let objectNumber: String
    
    init(objectNumber: String,
         language: Language = .en,
         format: Format = .json) {
        self.objectNumber = objectNumber
        super.init(language: language,
                   pagination: nil,
                   format: format,
                   sortParameter: nil,
                   imageOnly: nil)
    }
    
    @available(*, unavailable)
    required init(language: Language = .en, pagination: LimitOffset?, format: Format = .json, sortParameter: SortParameter?, imageOnly: Bool?) {
        fatalError("init(language:pagination:format:sortParameter:imageOnly:) has not been implemented")
    }
    
    override var builder: Parameters {
        Parameters { parameters in
            parameters.key <- key
            parameters.objectNumber <- objectNumber
            
            format.flatMap {
                parameters.format <- $0.rawValue
            }
        }
    }
}
