//
//  APIClient.swift
//  pokedexUIKIt
//
//  Created by Marlon David Ruiz Arroyave on 12/03/21.
//

import Foundation

protocol API {
    var baseURL: String { get }
    var networkDispatcher: NetworkDispatcherProtocol { get }
    func dispatch<R: Request>(_ request: R, completion:@escaping (Result<R.ReturnType, NetworkRequestError>) -> Void)
}

struct APIClient: API {
    let baseURL: String
    let networkDispatcher: NetworkDispatcherProtocol

    init(baseURL: String = Constants.baseURL, networkDispatcher: NetworkDispatcherProtocol = NetworkDispatcher()) {
        self.baseURL = baseURL
        self.networkDispatcher = networkDispatcher
    }

    /// Dispatches a Request and returns a Result
    /// - Parameter request: Request to Dispatch
    /// - Returns: A Result containing decoded data or an error
    func dispatch<R: Request>(_ request: R, completion:@escaping (Result<R.ReturnType, NetworkRequestError>) -> Void) {
        guard let urlRequest = request.asURLRequest(baseURL: baseURL) else {
            return completion(.failure(.badRequest))
        }

        networkDispatcher.dispatch(request: urlRequest, completion: completion)
    }
}
