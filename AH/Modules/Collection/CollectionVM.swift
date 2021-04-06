//
//  CollectionVM.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import ReactiveSwift

protocol CollectionVMDelegate: AnyObject {
    func collectionVM(_ viewModel: CollectionVM, didSelectExhibit exhibit: Exhibit)
}

final class CollectionVM: UseCasesConsumer {
    typealias UseCases = HasInformationUseCase & HasDownloadUseCase

    // MARK: - Public Properties
    
    let actions = ActionGroup()
    let pagination = MutableProperty(LimitOffset())
    
    // MARK: - Private Properties
    
    private weak var delegate: CollectionVMDelegate?

    // MARK: - Actions
    
    
    private(set) lazy var fetchExhibitsAction = Action(execute: fetchCollection)
    
    // MARK: - Life Cycle
    
    init(useCases: UseCases, delegate: CollectionVMDelegate) {
        self.useCases = useCases
        self.delegate = delegate
        setupActionGroup()
        setupObservers()
    }
    
    // MARK: - Helper methods
    
    func selectExhibitEntity(_ exhibitEntity: ExhibitEntity) {
//        fetchPokemonInfo.apply(Pokemon(from: pokemonEntity)).start()
    }

    // MARK: - Private methods

    private func setupActionGroup() {
        actions.append(fetchExhibitsAction)
//        actions.append(fetchPokemonInfo)
    }

    private func setupObservers() {
//        useCases
//            .information
//            .exhibitsCount
//            .signal
//            .take(duringLifetimeOf: self)
//            .observeValues { [weak self] exhibitsCount in
//                guard let self = self else { return }
//                self.pagination.value = LimitOffset(page: self.pagination.value.page,
//                                                    limit: self.pagination.value.limit,
//                                                    total: exhibitsCount)
//        }
//        fetchPokemonsAction.apply().start()
//        pagination <~ fetchPokemonsAction.values.map { $0.pagination }
//
//        fetchPokemonInfo
//            .values
//            .take(duringLifetimeOf: self)
//            .observe(on: UIScheduler())
//            .observeValues { [weak self] pokemon in
//                guard let viewModel = self else { return }
//                viewModel.delegate?.pokemonVM(viewModel, didSelectPokemon: pokemon)
//            }
    }

    private func fetchCollection() -> AsyncTask<Void> {
        guard let pagination = pagination.value.nextPage() else { return .empty }
        self.pagination.value = pagination
        return useCases.information.fetchCollection(with: BaseParameters(language: .en,
                                                                  pagination: self.pagination.value,
                                                                  format: .json,
                                                                  sortParameter: .artist,
                                                                  imageOnly: true))
    }
}

