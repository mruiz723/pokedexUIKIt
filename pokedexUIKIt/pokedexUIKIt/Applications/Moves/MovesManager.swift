//
//  MovesManager.swift
//  pokedexUIKIt
//
//  Created by Marlon David Ruiz Arroyave on 14/03/21.
//

import Foundation

struct MovesManager: MovesManagerProtocol {
    static var movesOffset = 0
    static let limit = 20
    static var count = 20
    var apiClient: API

    init(apiClient: API = APIClient()) {
        self.apiClient = apiClient
    }

    func fetchMovesList(completion: @escaping MovesListBlock) {
        apiClient.dispatch(MovesRequest()) { result in
            switch result {
            case .success(let pageObject):
                var newMoves: [Move] = []
                MovesManager.count = pageObject.count
                pageObject.results.forEach { item in
                    fetchMove(by: item.name) { result in
                        switch result {
                        case .success(let move):
                            newMoves.append(move)
                            if newMoves.count == MovesManager.limit {
                                newMoves.sort(by: {
                                    $0.id < $1.id
                                })
                                completion(.success(newMoves))
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

    func fetchMove(by name: String, completion: @escaping MoveBlock) {
        apiClient.dispatch(MoveRequest(name: name), completion: completion)
    }
}

struct MovesRequest: Request {
    typealias ReturnType = PageObject
    var path: String = "/move"
    var queryItems: [URLQueryItem]? = nil

    init() {
        let offsetItem: URLQueryItem = URLQueryItem(name: Constants.offset, value: String(MovesManager.movesOffset))
        let limitItem: URLQueryItem = URLQueryItem(name: Constants.limit, value: String(MovesManager.limit))
        MovesManager.movesOffset += MovesManager.limit

        queryItems = [offsetItem, limitItem]
    }
}

struct MoveRequest: Request {
    typealias ReturnType = Move
    let path: String

    init(name: String) {
        path = "/move/\(name)"
    }
}
