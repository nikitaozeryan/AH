//
//  SortParameter.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

enum SortParameter: String {
    
    /// Sort results on relevance.
    case relevance = "relevance"
    
    /// Sort results on type.
    case objecttype = "objecttype"
    
    /// Sort results chronologically (oldest first).
    case chronologic = "chronologic"
    
    /// Sort results chronologically (newest first).
    case achronologic = "achronologic"
    
    /// Sort results on artist (a-z).
    case artist = "artist"
    
    /// Sort results on artist (z-a).
    case artistdesc = "artistdesc"
}
