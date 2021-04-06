//
//  CollectionVC.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import ReactiveSwift
import UIKit
import CoreData

extension CollectionVC: Makeable {
    static func make() -> CollectionVC {
        return CollectionVC()
    }
}

final class CollectionVC: BaseVC, ViewModelContainer {
    
    // MARK: - Properties
    
    private lazy var mainView: ExhibitCollectionView = {
        ExhibitCollectionView(dataSource: self, delegate: self, pinterestDelegate: self)
    }()
    
    private lazy var loader: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    // MARK: - Private properties
    
    private var exhibitsFRC: NSFetchedResultsController<ExhibitEntity>?
    private var sectionChanges = [(type: NSFetchedResultsChangeType, sectionIndex: Int)]()
    private var itemChanges = [(type: NSFetchedResultsChangeType, indexPath: IndexPath?, newIndexPath: IndexPath?)]()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func didSetViewModel(_ viewModel: CollectionVM, lifetime: Lifetime) {
        viewModel.useCases.information.setupProducer.startWithResult { [weak self] result in
            guard let viewController = self else { return }
            switch result {
            case .success(let database):
                viewController.setupFRC(with: database.viewContext)
            case .failure(let error):
                viewController.showErrorAlert(error)
            }
        }
        loader.reactive.isAnimating <~ viewModel.fetchExhibitsAction.isExecuting
        
        let activityActionGroup = ActionGroup()
        activityActionGroup.append(viewModel.fetchExhibitDetailsAction)
        
        reactive.activity <~ activityActionGroup.isExecuting
        reactive.errors <~ viewModel.actions.errors
    }
    
    // MARK: - Helper methods
    
    private func setup() {
        navigationItem.title = localizedString(key: "collectionVC.title").uppercased()
        let barItem = UIBarButtonItem(customView: loader)
        navigationItem.rightBarButtonItem = barItem
    }
    
    private func setupFRC(with context: NSManagedObjectContext) {
        exhibitsFRC = NSFetchedResultsController(fetchRequest: viewModel.useCases.information.exhibitsFetchRequest(),
                                                 managedObjectContext: context,
                                                 sectionNameKeyPath: NSExpression(forKeyPath: \ExhibitEntity.painter).keyPath,
                                                 cacheName: nil)
        exhibitsFRC?.delegate = self
        do {
            try exhibitsFRC?.performFetch()
            if exhibitsFRC?.fetchedObjects?.count == 0 {
                viewModel.fetchExhibitsAction.apply().start()
            }
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
    
    private func estimatedLabelHeight(text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let size = CGSize(width: width, height: .greatestFiniteMagnitude)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: font]
        let rectangleHeight = String(text).boundingRect(with: size, options: options, attributes: attributes, context: nil).height
        
        return rectangleHeight
    }
}

// MARK: - UICollectionViewDataSource

extension CollectionVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        exhibitsFRC?.sections?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        exhibitsFRC?.sections?[section].objects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let exhibitEntity = exhibitsFRC?.object(at: indexPath),
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ExhibitCVC.self),
                                                                for: indexPath) as? ExhibitCVC else { return UICollectionViewCell() }
        cell.configure(with: exhibitEntity)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let title = exhibitsFRC?.sections?[indexPath.section].name else { return UICollectionReusableView() }
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: String(describing: CollectionViewHeader.self),
                                                                               for: indexPath) as? CollectionViewHeader else { return UICollectionReusableView() }
            header.configure(with: title)
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        CGSize(width: collectionView.frame.width - collectionView.contentInset.left - collectionView.contentInset.right, height: headerHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        
        .zero
    }
}

// MARK: - UICollectionViewDelegate

extension CollectionVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        guard let exhibitEntity = exhibitsFRC?.object(at: indexPath) else { return }
        viewModel.selectExhibitEntity(exhibitEntity)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == mainView.collectionView,
              viewModel.pagination.value.hasMore,
              scrollView.contentOffset.y > 0 else { return }
        
        if scrollView.contentOffset.y + (UIScreen.main.bounds.height * 2) >= scrollView.contentSize.height
            && !viewModel.fetchExhibitsAction.isExecuting.value {
            viewModel.fetchExhibitsAction.apply().start()
        }
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension CollectionVC: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        
        
        sectionChanges.append((type, sectionIndex))
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        
        itemChanges.append((type, indexPath, newIndexPath))
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        mainView.collectionView.performBatchUpdates({
            
            for change in self.sectionChanges {
                switch change.type {
                case .insert: self.mainView.collectionView.insertSections([change.sectionIndex])
                case .delete: self.mainView.collectionView.deleteSections([change.sectionIndex])
                case .update: self.mainView.collectionView.reloadSections([change.sectionIndex])
                default: break
                }
            }
            
            for change in self.itemChanges {
                switch change.type {
                case .insert: self.mainView.collectionView.insertItems(at: [change.newIndexPath!])
                case .delete: self.mainView.collectionView.deleteItems(at: [change.indexPath!])
                case .update: self.mainView.collectionView.reloadItems(at: [change.indexPath!])
                case .move:
                    self.mainView.collectionView.deleteItems(at: [change.indexPath!])
                    self.mainView.collectionView.insertItems(at: [change.newIndexPath!])
                @unknown default:
                    return
                }
            }
            
        }, completion: { finished in
            self.sectionChanges.removeAll()
            self.itemChanges.removeAll()
        })
    }
}

// MARK: - PinterestLayoutDelegate

extension CollectionVC: PinterestLayoutDelegate {
    func heightForCell(at indexPath: IndexPath,
                       in section: Int,
                       forCollectionView collectionView: UICollectionView) -> CGFloat {
        
        guard let exhibitEntity = exhibitsFRC?.object(at: indexPath),
              let image = exhibitEntity.image else {
            return .zero
        }
        
        let width = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right)) / 2 - offset
        
        let titleLabelHeight = estimatedLabelHeight(text: exhibitEntity.title, width: width, font: UIFont.systemFont(ofSize: defaultFontSize))
        let descriptionLabelHeight = estimatedLabelHeight(text: exhibitEntity.longTitle, width: width, font: UIFont.systemFont(ofSize: titleFontSize))
        return width / CGFloat(image.width) * CGFloat(image.height) + titleLabelHeight + descriptionLabelHeight + offset * 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
}
