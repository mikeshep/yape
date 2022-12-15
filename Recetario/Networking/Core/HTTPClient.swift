//
//  HTTPClient.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Router, responseModel: T.Type) async throws -> T
}

/// Usage let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
extension HTTPClient {
    func sendRequest<T: Decodable>(
        endpoint: Router,
        responseModel: T.Type
    ) async throws -> T {

        var request = URLComponents(string: endpoint.url)!

        if let parameters = endpoint.parameters {
            request.queryItems = parameters
        }

        guard let url = request.url else { throw RecipeServiceError.invalidURL }

        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        for header in endpoint.headers {
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }
        urlRequest.httpBody = endpoint.body
        
        urlRequest.httpMethod = endpoint.method

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                throw RecipeServiceError.noResponse
            }
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    throw RecipeServiceError.decode
                }
                return decodedResponse
            case 401:
                throw RecipeServiceError.unauthorised
            default:
                throw RecipeServiceError.unknown
            }
        } catch URLError.Code.notConnectedToInternet {
            throw RecipeServiceError.offline
        }
    }
}
