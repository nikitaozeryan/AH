//
//  CollectionViewHeader.swift
//  AH
//
//  Created by Nikita Ozerian on 06.04.2021.
//

import UIKit

final class CollectionViewHeader: UICollectionReusableView {
    
    // MARK: - Views
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: defaultFontSize)
        label.numberOfLines = 0
        label.textColor = titleColor
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    // MARK: - Lifecycle
    
    init() {
        super.init(frame: .zero)
        
        setup()
        setupConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    func configure(with title: String) {
        titleLabel.text = title
    }
    
    // MARK: - Private methods
    
    private func setup() {
        backgroundColor = .lightGray
        addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(headerHeight)
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().inset(offset)
        }
    }
}
