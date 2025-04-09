//
//  HTTPDataDownloader.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 05.04.2025.
//

import Foundation

protocol HTTPDataDownloader {
    func httpData(for request: URLRequest) async throws -> Data
}

extension URLSession: HTTPDataDownloader {

    func httpData(for request: URLRequest) async throws -> Data {
        let (data, response) = try await self.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        switch httpResponse.statusCode {
        case 200 ... 299:
            return data
        //TODO: - Add errors handaling later, refresh short token
        default:
            throw APIError.statusCode(httpResponse.statusCode)
        }
    }
}
