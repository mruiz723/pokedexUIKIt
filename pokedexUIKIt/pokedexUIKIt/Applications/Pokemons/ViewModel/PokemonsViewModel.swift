//
//  PokemonsViewModel.swift
//  pokedexUIKIt
//
//  Created by Marlon David Ruiz Arroyave on 12/03/21.
//

import Foundation
import MRCommons

class PokemonsViewModel: PokemonsViewModelProtocol {

    // MARK: Properties

    let pokemonsManager: PokemonsManagerProtocol
    var pokemons: Bindable<[Pokemon]?> = Bindable(nil)
    private var pokemonsCopy: [Pokemon] = []

    // MARK: Events

    var showPokemonDetail: ((_ pokemon: Pokemon) -> Void)?
    var shouldShowLoader: ((Bool) -> Void)?
    var showAlert: ((_ message: String) -> Void)?

    // MARK: Initializer

    init(pokemonsManager: PokemonsManagerProtocol = PokemonsManager()) {
        self.pokemonsManager = pokemonsManager
    }

    // MARK: Public Methods

    func viewDidLoad() {
        fetchPokemonsList()
    }

    func fetchPokemonsList() {
        shouldShowLoader?(true)

        pokemonsManager.fetchPokemonsList { result in
            DispatchQueue.main.async { [weak self] in
                self?.shouldShowLoader?(false)
                switch result {
                case .success(let pokemons):
                    self?.pokemons.value = pokemons
                case .failure(let error):
                    self?.showAlert?(error.localizedDescription)
                }
            }
        }
    }

    func filterPokemons(name: String?) {
        if pokemonsCopy.count == 0 {
            pokemonsCopy = pokemons.value ?? []
        }

        guard let name = name, name.count > 0 else {
            pokemons.value = pokemonsCopy
            return
        }

        pokemons.value = pokemons.value?.filter { pokemon in
            (pokemon.name.lowercased().contains(name.lowercased()))
        }
    }

    func didSelectRow(at index: Int) {
        guard let pokemon = pokemons.value?[index] else {
            fatalError("Pokemon is required")
        }

        showPokemonDetail?(pokemon)
    }

    func makeViewModelForPokemonCell(at indexPath: IndexPath) -> PokemonCellViewModel {
        guard let pokemon = pokemons.value?[indexPath.row] else {
            fatalError("Pokemon is required")
        }

        return PokemonCellViewModel(pokemon: pokemon)
    }

    func willDisplayLastCell() {
        // Load more data if list is not filtered
        if PokemonsManager.pokemonsOffset == pokemons.value?.count {
            // Load more data
            shouldShowLoader?(true)

            pokemonsManager.fetchPokemonsList { result in
                DispatchQueue.main.async { [weak self] in
                    self?.shouldShowLoader?(false)
                    switch result {
                    case .success(let pokemons):
                        self?.pokemons.value?.append(contentsOf: pokemons)
                    case .failure(let error):
                        self?.showAlert?(error.localizedDescription)
                    }
                }
            }
        }
    }
}
