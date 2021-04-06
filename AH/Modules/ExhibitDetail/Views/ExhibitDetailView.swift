//
//  ExhibitDetailView.swift
//  AH
//
//  Created by Nikita Ozerian on 06.04.2021.
//

import UIKit

final class ExhibitDetailView: UIView {
    
    // MARK: - Views
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsets(top: .zero,
                                                left: offset,
                                                bottom: .zero,
                                                right: .zero)
        
        tableView.register(DetailTVC.self)
        tableView.register(ExhibitDetailHeaderView.self)
        tableView.estimatedRowHeight = 50
        tableView.estimatedSectionHeaderHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        return tableView
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
        
        addSubview(tableView)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
