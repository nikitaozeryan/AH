//
//  ExhibitCollectionView.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import UIKit
import SnapKit

final class ExhibitCollectionView: UIView {
    
    // MARK: - Views
    
    let collectionView: UICollectionView
    
    // MARK: - Lifecycle
    
    init(dataSource: UICollectionViewDataSource,
         delegate: UICollectionViewDelegate,
         pinterestDelegate: PinterestLayoutDelegate) {
        
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: PinterestLayout())
        
        super.init(frame: .zero)
        
        setup(dataSource: dataSource,
              delegate: delegate,
              pinterestDelegate: pinterestDelegate)
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper methods
    
    private func setup(dataSource: UICollectionViewDataSource,
                       delegate: UICollectionViewDelegate,
                       pinterestDelegate: PinterestLayoutDelegate) {
        
        backgroundColor = .white
        
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
          layout.delegate = pinterestDelegate
        }
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ExhibitCVC.self,
                                forCellWithReuseIdentifier: String(describing: ExhibitCVC.self))
        collectionView.register(CollectionViewHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: String(describing: CollectionViewHeader.self))
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        collectionView.backgroundColor = .clear
        addSubview(collectionView)
           
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
