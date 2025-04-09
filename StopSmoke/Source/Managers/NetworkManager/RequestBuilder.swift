//
//  RequestBuilder.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 05.04.2025.
//

import Foundation

final class RequestBuilder {

    func makeRequest(from endpoint: Endpoint) throws -> URLRequest {
        let url = try makeUrl(from: endpoint)
        var request = URLRequest(url: url)
            .add(httpMethod: endpoint.method)
        if let requestDTO = endpoint.request {
            request = request.add(body: requestDTO)
        }
        if let shortToken = KeychainService.getToken(keyType: .shortToken) {
            request.addValue("Bearer \(shortToken)", forHTTPHeaderField: "Authorization")
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}

// MARK: - Private methods

private extension RequestBuilder {

    func makeUrl(from endpoint: Endpoint) throws -> URL {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "127.0.0.1"
        components.port = 8080
        components.path = endpoint.path
        guard let url = components.url else {
            throw APIError.invalidUrl
        }
        return url
    }
}
