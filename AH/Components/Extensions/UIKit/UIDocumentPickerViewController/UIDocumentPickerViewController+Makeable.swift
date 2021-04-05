//
//  UIDocumentPickerViewController+Makeable.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import UIKit
import CoreServices

extension UIDocumentPickerViewController: Makeable {
    static func make() -> UIDocumentPickerViewController {
        UIDocumentPickerViewController(documentTypes: [kUTTypePDF as String], in: .open)
    }
}
