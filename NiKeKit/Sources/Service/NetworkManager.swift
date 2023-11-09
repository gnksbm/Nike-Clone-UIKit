//
//  NetworkManager.swift
//  URLImageKit
//
//  Created by gnksbm on 2023/10/06.
//

import Foundation

enum NetworkError: Error {
    case transportError(Error)
    case invalidStatusCode
    case invalidData
    case parseError
}

final class NetworkManager {
    static let shared = NetworkManager()

    private init() { }

    func fetchData(url: URL) async -> Result<Data, NetworkError> {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse,
                  200..<300 ~= response.statusCode else {
                return .failure(.invalidStatusCode)
            }
            return .success(data)
        } catch {
            return .failure(.transportError(error))
        }
    }
    
    func fetchObject<T: Decodable>(type: T.Type, url: URL) async -> Result<T, NetworkError> {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse,
                  200..<300 ~= response.statusCode else {
                return .failure(.invalidStatusCode)
            }
            guard let result = try? JSONDecoder().decode(T.self, from: data) else { return .failure(.parseError) }
            return .success(result)
        } catch {
            return .failure(.transportError(error))
        }
    }
}
