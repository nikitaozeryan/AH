//
//  Constants.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import UIKit


typealias BaseModelsPage = (models: [BaseModel], pagination: LimitOffset)

public let offset: CGFloat = 16.0
public let titleFontSize: CGFloat = 14.0
public let defaultFontSize: CGFloat = 16.0
public let defaultHeaderHeight: CGFloat = 54.0
public let defaultImageSize = CGSize(width: 64.0, height: 64.0)
public let defaultLoaderSize = CGSize(width: 48.0, height: 48.0)
public let screenWidth = UIScreen.main.bounds.width
public let screenHeight = UIScreen.main.bounds.height
public let defaultLanguage = "en"
public let titleColor = UIColor(red: 52/255, green: 53/255, blue: 55/255, alpha: 1.0)
public let descriptionColor = UIColor(red: 164/255, green: 171/255, blue: 173/255, alpha: 1.0)
public let headerHeight: CGFloat = 30.0

public let imagePlaceholder = UIImage(named: "placeholder")


public var baseURL: URL = {
    guard let url = URL(string: "https://www.rijksmuseum.nl") else {
        fatalError("Check baseURL")
    }
    return url
}()

public func localizedString(key: String) -> String {
    return NSLocalizedString(key, comment: "")
}

public func configureID(from ownerID: Int64, string: String) -> String {
    "\(ownerID) \(string)"
}
