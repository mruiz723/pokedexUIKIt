//
//  MovesManagerProtocol.swift
//  pokedexUIKIt
//
//  Created by Marlon David Ruiz Arroyave on 14/03/21.
//

import Foundation

typealias MovesListBlock = (Result<[Move], NetworkRequestError>) -> Void
typealias MoveBlock = (Result<Move, NetworkRequestError>) -> Void

protocol MovesManagerProtocol {
    var apiClient: API { get set }
    func fetchMovesList(completion: @escaping MovesListBlock)
    func fetchMove(by name: String, completion: @escaping MoveBlock)
}
