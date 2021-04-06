//
//  ExhibitDetailHeaderView.swift
//  AH
//
//  Created by Nikita Ozerian on 06.04.2021.
//

import UIKit

final class ExhibitDetailHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Views
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = imagePlaceholder
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: defaultFontSize)
        label.numberOfLines = 0
        label.textColor = .white
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
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setup()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    func configure(with exhibit: Exhibit) {
        titleLabel.text = exhibit.title
        descriptionLabel.text = exhibit.description
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
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(offset)
            $0.right.equalToSuperview().inset(offset)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(avatarImageView.snp.bottom).offset(offset)
            $0.leading.trailing.equalTo(avatarImageView)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(offset)
            $0.leading.trailing.equalTo(avatarImageView)
            $0.bottom.lessThanOrEqualToSuperview().inset(offset)
        }
    }
}
