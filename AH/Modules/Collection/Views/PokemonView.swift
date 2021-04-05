//
//  CollectionView.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import UIKit

final class CollectionView: UIView {
    
    // MARK: - Views
    
    private(set) lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        
//        tableView.register(PokemonTVC.self)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    init(dataSource: UITableViewDataSource,
         delegate: UITableViewDelegate) {
        super.init(frame: .zero)
        
        setup(dataSource: dataSource,
              delegate: delegate)
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper methods
    
    private func setup(dataSource: UITableViewDataSource,
                       delegate: UITableViewDelegate) {
        
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            backgroundColor = .white
        }
        
        addSubview(collectionView)
//        tableView.dataSource = dataSource
//        tableView.delegate = delegate
    }
    
    private func setupConstraints() {
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        let constraints = [
//            tableView.topAnchor.constraint(equalTo: topAnchor, constant: offset),
//            tableView.leftAnchor.constraint(equalTo: leftAnchor, constant: offset),
//            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: offset),
//            tableView.rightAnchor.constraint(equalTo: rightAnchor, constant: offset)
//        ]
//        NSLayoutConstraint.activate(constraints)
    }
}
