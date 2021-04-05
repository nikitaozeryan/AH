//  
//  RemoteDataUseCase.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import ReactiveSwift

protocol RemoteDataUseCase {
    var exhibitsCount: Int { get }
    
    func fetchCollection(with params: BaseParameters) -> AsyncTask<Void>
}
