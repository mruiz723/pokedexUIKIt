//
//  PokemonsManager.swift
//  pokedexUIKIt
//
//  Created by Marlon David Ruiz Arroyave on 13/03/21.
//

import Foundation

struct PokemonsManager: PokemonsManagerProtocol {
    static var pokemonsOffset = 0
    static let limit = 20
    static var count = 20
    var apiClient: API

    init(apiClient: API = APIClient()) {
        self.apiClient = apiClient
    }

    func fetchPokemonsList(completion: @escaping PokemonsListBlock) {
        apiClient.dispatch(PokemonsRequest()) { result in
            switch result {
            case .success(let pageObject):
                var newPokemons: [Pokemon] = []
                PokemonsManager.count = pageObject.count
                pageObject.results.forEach { item in
                    fetchPokemon(by: item.name) { result in
                        switch result {
                        case .success(let pokemon):
                            newPokemons.append(pokemon)
                            if newPokemons.count == PokemonsManager.limit {
                                newPokemons.sort(by: {
                                    $0.id < $1.id
                                })
                                completion(.success(newPokemons))
                            }
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchPokemon(by name: String, completion: @escaping PokemonBlock) {
        apiClient.dispatch(PokemonRequest(name: name), completion: completion)
    }
}

struct PokemonsRequest: Request {
    typealias ReturnType = PageObject
    var path: String = "/pokemon"
    var queryItems: [URLQueryItem]? = nil

    init() {
        let offsetItem: URLQueryItem = URLQueryItem(name: Constants.offset, value: String(PokemonsManager.pokemonsOffset))
        let limitItem: URLQueryItem = URLQueryItem(name: Constants.limit, value: String(PokemonsManager.limit))
        PokemonsManager.pokemonsOffset += PokemonsManager.limit

        queryItems = [offsetItem, limitItem]
    }
}

struct PokemonRequest: Request {
    typealias ReturnType = Pokemon
    let path: String

    init(name: String) {
        path = "/pokemon/\(name)"
    }
}
