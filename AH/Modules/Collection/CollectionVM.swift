//
//  CollectionVM.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import ReactiveSwift

protocol CollectionVMDelegate: AnyObject {
    func collectionVM(_ viewModel: CollectionVM, didSelectExhibit exhibit: ExhibitWithDetails)
}

final class CollectionVM: UseCasesConsumer {
    typealias UseCases = HasInformationUseCase & HasDownloadUseCase

    // MARK: - Public Properties
    
    let actions = ActionGroup()
    let pagination = MutableProperty(LimitOffset())
    
    // MARK: - Private Properties
    
    private weak var delegate: CollectionVMDelegate?

    // MARK: - Actions

    private(set) lazy var fetchExhibitsAction = Action.observedExecute(fetchCollection)
    private(set) lazy var fetchExhibitDetailsAction = Action.observedExecute(useCases.information.fetchExhibitDetails)
    
    // MARK: - Life Cycle
    
    init(useCases: UseCases, delegate: CollectionVMDelegate) {
        self.useCases = useCases
        self.delegate = delegate
        setupActionGroup()
        setupObservers()
    }
    
    // MARK: - Helper methods
    
    func selectExhibitEntity(_ exhibitEntity: ExhibitEntity) {
        fetchExhibitDetailsAction.apply(ExhibitDetailParameters(objectNumber: exhibitEntity.objectNumber)).start()
    }

    // MARK: - Private methods

    private func setupActionGroup() {
        actions.append(fetchExhibitsAction)
        actions.append(fetchExhibitDetailsAction)
    }

    private func setupObservers() {        
        fetchExhibitDetailsAction
            .values
            .skipNil()
            .take(duringLifetimeOf: self)
            .observeValues { [weak self] details in
                guard let self = self else { return }
                self.delegate?.collectionVM(self, didSelectExhibit: details)
            }
    }

    private func fetchCollection() -> AsyncTask<Void> {
        guard let pagination = pagination.value.nextPage() else { return .empty }
        self.pagination.value = pagination
        return useCases.information.fetchAndSaveCollection(with: BaseParameters(language: .en,
                                                                  pagination: self.pagination.value,
                                                                  format: .json,
                                                                  sortParameter: .artist,
                                                                  imageOnly: true))
    }
}

