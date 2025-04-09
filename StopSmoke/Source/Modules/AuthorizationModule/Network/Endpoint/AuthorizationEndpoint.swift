//
//  AuthorizationEndpoint.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 06.04.2025.
//

import Foundation

enum AuthorizationEndpoint {
    case createAccount(login: String, password: String)
    case authorize(login: String, password: String)
    case authorizeWithRefreshToken(_ token: String)
}

extension AuthorizationEndpoint: Endpoint {
    
    var path: String {
        switch self {
        case .createAccount(_, _):
            "/auth/register"
        case .authorize(_, _):
            "/auth/login"
        case .authorizeWithRefreshToken(_):
            "/auth/refresh"
        }
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var request: Encodable? {
        switch self {
        case .createAccount(let login, let password):
            AuthorizationModel.AuthorizationRequest(username: login, password: password)
        case .authorize(let login, let password):
            AuthorizationModel.AuthorizationRequest(username: login, password: password)
        case .authorizeWithRefreshToken(let token):
            AuthorizationModel.RefreshTokensRequest(token: token)
        }
    }
    
    var shortToken: String? {
        nil
    }
}
