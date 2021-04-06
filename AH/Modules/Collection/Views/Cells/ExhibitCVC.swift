//
//  ExhibitCVC.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import UIKit
import SDWebImage

final class ExhibitCVC: UICollectionViewCell {
    private enum C {
        static let cvcOffset = offset / 2
    }
    
    // MARK: - Properties
    
    private var media: Media?
    
    // MARK: - Views
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = imagePlaceholder
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: defaultFontSize)
        label.numberOfLines = 0
        label.textColor = titleColor
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: titleFontSize)
        label.numberOfLines = 0
        label.textColor = descriptionColor
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
    
    func configure(with exhibit: ExhibitEntity) {
        titleLabel.text = exhibit.title
        descriptionLabel.text = exhibit.longTitle
        avatarImageView.image = imagePlaceholder
        exhibit.image.flatMap { image in
            URL(string: image.url).flatMap {
                avatarImageView.sd_setImage(with: $0, placeholderImage: imagePlaceholder)
            }
        }
    }
    
    // MARK: - Private methods
    
    private func setup() {
        contentView.addSubview(containerView)
        containerView.addSubview(avatarImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { $0.edges.equalTo(contentView) }
        
        avatarImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(C.cvcOffset)
            $0.leading.equalToSuperview().offset(C.cvcOffset)
            $0.trailing.equalToSuperview().inset(C.cvcOffset)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(avatarImageView.snp.bottom).offset(C.cvcOffset)
            $0.leading.trailing.equalTo(avatarImageView)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(C.cvcOffset)
            $0.leading.trailing.equalTo(avatarImageView)
            $0.bottom.lessThanOrEqualToSuperview().inset(C.cvcOffset)
        }
    }
}
