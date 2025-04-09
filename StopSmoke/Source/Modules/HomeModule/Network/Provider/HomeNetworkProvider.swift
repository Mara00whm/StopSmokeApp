//
//  HomeNetworkProvider.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 06.04.2025.
//

import Foundation

final class HomeNetworkProvider {
    
    // MARK: - Private properties

    private let httpClient: HTTPClient
    private typealias Endpoint = HomeNetworkEndpoint
    
    // MARK: - Init

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    // MARK: - Public methods

    func smoke() async throws {
        try await httpClient.data(endpoint: Endpoint.smoke)
    }
    
    func cigarettes() async throws -> HomeNetworkModel.CigarettesDto {
        try await httpClient.data(from: Endpoint.cigarettes)
    }
}
