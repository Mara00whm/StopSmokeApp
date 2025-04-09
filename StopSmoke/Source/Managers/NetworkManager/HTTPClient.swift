//
//  HTTPClient.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 05.04.2025.
//

import Foundation

final class HTTPClient {

    private let downloader: any HTTPDataDownloader
    private let requestBuilder: RequestBuilder

    private lazy var decoder: JSONDecoder = {
        let aDecoder = JSONDecoder()
        aDecoder.dateDecodingStrategy = .iso8601
        return aDecoder
    }()

    init(downloader: any HTTPDataDownloader = URLSession.shared, requestBuilder: RequestBuilder = .init()) {
        self.downloader = downloader
        self.requestBuilder = requestBuilder
    }
}

extension HTTPClient {

    @discardableResult
    func data(endpoint: Endpoint) async throws -> Data {
        let request = try requestBuilder.makeRequest(from: endpoint)
        return try await downloader.httpData(for: request)
    }

    func data<T: Decodable>(from endpoint: Endpoint) async throws -> T {
        let request = try requestBuilder.makeRequest(from: endpoint)
        let data = try await downloader.httpData(for: request)
        return try decoder.decode(from: data)
    }
}
