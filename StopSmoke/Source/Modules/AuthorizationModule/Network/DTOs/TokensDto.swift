//
//  TokensDto.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 06.04.2025.
//

import Foundation

enum AuthorizationModel {
    
    // MARK: - Responses

    struct TokensDto: Decodable {
        /// Long live, 30 days
        let refreshToken: String
        /// Short live, 1 hour
        let accessToken: String
    }
    
    struct ShortTokenDto: Decodable {
        let accessToken: String
    }
    
    // MARK: - Requests

    struct RefreshTokensRequest: Encodable {
        let token: String
    }
    
    struct AuthorizationRequest: Encodable {
        let username: String
        let password: String
    }
}
