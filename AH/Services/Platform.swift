//
//  Platform.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import UIKit

final class Platform: UseCasesProvider {
    
    // MARK: - UseCases
    
    var remoteData: RemoteDataUseCase
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
        remoteData = RemoteDataService(network: network, database: database)
    }
}
