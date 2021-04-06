//
//  UseCasesProvider.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

internal protocol HasInformationUseCase {
    var information: InformationUseCase { get }
}

internal protocol HasDownloadUseCase {
    var download: DownloadUseCase { get }
}

typealias UseCases = HasInformationUseCase
    & HasDownloadUseCase

protocol UseCasesProvider: UseCases {}

