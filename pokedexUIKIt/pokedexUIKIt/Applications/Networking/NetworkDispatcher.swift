//
//  NetworkDispatcher.swift
//  pokedexUIKIt
//
//  Created by Marlon David Ruiz Arroyave on 11/03/21.
//

import Foundation

enum NetworkRequestError: LocalizedError, Equatable {
    case invalidRequest
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case error4xx(_ code: Int)
    case serverError
    case error5xx(_ code: Int)
    case decodingError
    case urlSessionFailed(_ error: URLError)
    case unknownError
}

protocol NetworkDispatcherProtocol {
    var urlSession: URLSession { get }
    func dispatch<ReturnType: Codable>(request: URLRequest, completion: @escaping (Result<ReturnType, NetworkRequestError>) -> Void)
}

struct NetworkDispatcher: NetworkDispatcherProtocol {
    let urlSession: URLSession

    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    /// Dispatches an URLRequest and returns a publisher
    /// - Parameter request: URLRequest
    /// - Returns: A publisher with the provided decoded data or an error
    func dispatch<ReturnType: Codable>(request: URLRequest, completion: @escaping (Result<ReturnType, NetworkRequestError>) -> Void) {
        urlSession.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(handleError(error)))
            }

            if let response = response as? HTTPURLResponse,
               !(200...299).contains(response.statusCode) {
                completion(.failure(httpError(response.statusCode)))
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            guard let data = data, let returnType = try? decoder.decode(ReturnType.self, from: data) else {
                return completion(.failure(.decodingError))
            }

            completion(.success(returnType))
        }.resume()
    }
}

extension NetworkDispatcher {
    /// Parses a HTTP StatusCode and returns a proper error
    /// - Parameter statusCode: HTTP status code
    /// - Returns: Mapped Error
    private func httpError(_ statusCode: Int) -> NetworkRequestError {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 402, 405...499: return .error4xx(statusCode)
        case 500: return .serverError
        case 501...599: return .error5xx(statusCode)
        default: return .unknownError
        }
    }
    /// Parses URLSession Publisher errors and return proper ones
    /// - Parameter error: URLSession publisher error
    /// - Returns: Readable NetworkRequestError
    private func handleError(_ error: Error) -> NetworkRequestError {
        switch error {
        case is Swift.DecodingError:
            return .decodingError
        case let urlError as URLError:
            return .urlSessionFailed(urlError)
        case let error as NetworkRequestError:
            return error
        default:
            return .unknownError
        }
    }
}


