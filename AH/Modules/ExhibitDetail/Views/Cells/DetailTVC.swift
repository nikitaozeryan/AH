//
//  DetailTVC.swift
//  AH
//
//  Created by Nikita Ozerian on 06.04.2021.
//

import UIKit

final class DetailTVC: UITableViewCell {
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    func configure(with title: String, detail: String) {
        textLabel?.text = title
        detailTextLabel?.text = detail
    }
    
    // MARK: - Private methods
    
    private func setup() {
        textLabel?.numberOfLines = 0
        detailTextLabel?.numberOfLines = 0
        selectionStyle = .none
    }
}
