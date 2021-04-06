//
//  ExhibitDetailVC.swift
//  AH
//
//  Created by Nikita Ozerian on 06.04.2021.
//

import ReactiveSwift
import UIKit

extension ExhibitDetailVC: Makeable {
    static func make() -> ExhibitDetailVC {
        return ExhibitDetailVC()
    }
}

final class ExhibitDetailVC: BaseVC, ViewModelContainer {
    
    // MARK: - Properties
    
    private lazy var mainView: ExhibitDetailView = {
        ExhibitDetailView(dataSource: self, delegate: self)
    }()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    func didSetViewModel(_ viewModel: ExhibitDetailVM, lifetime: Lifetime) {
        navigationItem.title = localizedString(key: "exhibitDetailVC.title")
        mainView.tableView.reloadData()
    }
    
    // MARK: - Helper methods
    
    private func estimatedLabelHeight(text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let size = CGSize(width: width, height: .greatestFiniteMagnitude)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: font]
        let rectangleHeight = String(text).boundingRect(with: size, options: options, attributes: attributes, context: nil).height
        
        return rectangleHeight
    }
}

// MARK: - UITableViewDataSource

extension ExhibitDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.detailsDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: DetailTVC.self)
        cell.configure(with: viewModel.detailsDataSource[indexPath.row].title,
                       detail: viewModel.detailsDataSource[indexPath.row].detail)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ExhibitDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeader(headerClass: ExhibitDetailHeaderView.self)
        header.configure(with: viewModel.exhibitWithDetails.exhibit)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let image = viewModel.exhibitWithDetails.exhibit.image else { return .leastNormalMagnitude }
        let width = (tableView.frame.width - (tableView.contentInset.left + tableView.contentInset.right)) - offset * 2
        
        let titleLabelHeight = estimatedLabelHeight(text: viewModel.exhibitWithDetails.exhibit.title,
                                                    width: width,
                                                    font: UIFont.systemFont(ofSize: defaultFontSize))
        let descriptionLabelHeight = estimatedLabelHeight(text: viewModel.exhibitWithDetails.exhibit.description,
                                                          width: width,
                                                          font: UIFont.systemFont(ofSize: titleFontSize))
        return width / CGFloat(image.width) * CGFloat(image.height) + titleLabelHeight + descriptionLabelHeight + offset * 4
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
}
