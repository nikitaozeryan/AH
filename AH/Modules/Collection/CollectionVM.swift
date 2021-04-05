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
    typealias UseCases = HasRemoteDataUseCase
    private enum C {
        static let searchLimit: Int = 30
    }

    // MARK: - Public Properties
    
    let actions = ActionGroup()
    let pagination = MutableProperty(LimitOffset(limit: C.searchLimit))
    
    // MARK: - Private Properties
    
    private weak var delegate: CollectionVMDelegate?

    // MARK: - Actions
    
//    private(set) lazy var fetchPokemonsAction = Action(execute: fetchPokemons)
//    private(set) lazy var fetchPokemonInfo = Action(execute: useCases.pokemon.fetchInfo)
    
    // MARK: - Life Cycle
    
    init(useCases: UseCases, delegate: CollectionVMDelegate) {
        self.useCases = useCases
        self.delegate = delegate
//        setupActionGroup()
//        setupObservers()
    }
    
    // MARK: - Helper methods
    
//    func selectPokemonEntity(_ pokemonEntity: PokemonEntity) {
//        fetchPokemonInfo.apply(Pokemon(from: pokemonEntity)).start()
//    }
//
//    // MARK: - Private methods
//
//    private func setupActionGroup() {
//        actions.append(fetchPokemonsAction)
//        actions.append(fetchPokemonInfo)
//    }
//
//    private func setupObservers() {
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
//    }
//
//    private func fetchPokemons(offset: Int) -> AsyncTask<PokemonsPage> {
//        useCases.pokemon.fetchPokemonList(with: LimitOffset(offset: offset))
//    }
}

