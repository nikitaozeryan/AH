//
//  DownloadUseCase.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

protocol DownloadUseCase {
    @discardableResult
    func addDownload(from url: URL, ownerID: String) -> Media?
    
    @discardableResult
    func startDownload(for media: Media) -> Bool
    
    @discardableResult
    func cancelDownload(for media: Media) -> Bool
}
