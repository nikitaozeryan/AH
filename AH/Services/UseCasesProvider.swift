//
//  UseCasesProvider.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

internal protocol HasRemoteDataUseCase {
    var remoteData: RemoteDataUseCase { get }
}

typealias UseCases = HasRemoteDataUseCase

protocol UseCasesProvider: UseCases {}

