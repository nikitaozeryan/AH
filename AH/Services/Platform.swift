//
//  Platform.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import UIKit

final class Platform: UseCasesProvider {
    
    // MARK: - UseCases
    
    var information: InformationUseCase
    var download: DownloadUseCase
    let imageCache = NSCache<NSString, UIImage>()
    
    // MARK: - Private Properties
    
    private var network: Network
    private let database: CoreDataDatabase
    
    // MARK: - Lifecycle
    
    init() {
        let plugins: [NetworkPlugin] = [APIErrorPlugin()]
        
        network = Network(baseURL: baseURL,
                          plugins: plugins)
        database = CoreDataDatabase()
        download = DownloadService(imageCache: imageCache)
        information = InformationService(network: network, database: database)
    }
}
