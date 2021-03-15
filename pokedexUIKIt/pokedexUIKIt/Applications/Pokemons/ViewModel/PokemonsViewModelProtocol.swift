//
//  PokemonsViewModelProtocol.swift
//  pokedexUIKIt
//
//  Created by Marlon David Ruiz Arroyave on 12/03/21.
//

import Foundation
import MRCommons

protocol PokemonsViewModelProtocol: BaseViewModelProtocol {
    var pokemonsManager: PokemonsManagerProtocol { get }
    var pokemons: Bindable<[Pokemon]?> { get set }
    var showPokemonDetail: ((_ pokemon: Pokemon) -> Void)? { get set }
    func fetchPokemonsList()
    func makeViewModelForPokemonCell(at indexPath: IndexPath) -> PokemonCellViewModel
    func didSelectRow(at index: Int)
    func viewDidLoad()
    func willDisplayLastCell()
    func filterPokemons(name: String?)
}
