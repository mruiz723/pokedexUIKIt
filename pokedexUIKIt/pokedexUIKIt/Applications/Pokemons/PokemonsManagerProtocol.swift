//
//  PokemonsManagerProtocol.swift
//  pokedexUIKIt
//
//  Created by Marlon David Ruiz Arroyave on 13/03/21.
//

import Foundation

typealias PokemonsListBlock = (Result<[Pokemon], NetworkRequestError>) -> Void
typealias PokemonBlock = (Result<Pokemon, NetworkRequestError>) -> Void

protocol PokemonsManagerProtocol {
    var apiClient: API { get set }
    func fetchPokemonsList(completion: @escaping PokemonsListBlock)
    func fetchPokemon(by name: String, completion: @escaping PokemonBlock)
}
