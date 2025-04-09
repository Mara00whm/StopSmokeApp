//
//  AuthorizationProvider.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 06.04.2025.
//

import Foundation

final class AuthorizationProvider {
    
    // MARK: - Private properties

    private let httpClient: HTTPClient
    private typealias Endpoint = AuthorizationEndpoint
    
    // MARK: - Init

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    // MARK: - Public methods

    func createAccount(for login: String, password: String) async throws -> AuthorizationModel.TokensDto {
        try await httpClient.data(from: Endpoint.createAccount(login: login, password: password))
    }
    
    func tryToAuthorize(with refreshToken: String) async throws -> AuthorizationModel.ShortTokenDto {
        try await httpClient.data(from: Endpoint.authorizeWithRefreshToken(refreshToken))
    }
    
    func logIn(with login: String, password: String) async throws -> AuthorizationModel.TokensDto {
        try await httpClient.data(from: Endpoint.authorize(login: login, password: password))
    }
}
