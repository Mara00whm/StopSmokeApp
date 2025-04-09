//
//  HomeNetworkEndpoint.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 06.04.2025.
//

import Foundation

enum HomeNetworkEndpoint {
    case smoke
    case cigarettes
}

extension HomeNetworkEndpoint: Endpoint {
    var path: String {
        switch self {
        case .smoke:
            "/smoke"
        case .cigarettes:
            "/cigarettes"
        }
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var request: (any Encodable)? {
        nil
    }
    
    var shortToken: String? {
        KeychainService.getToken(keyType: .shortToken)
    }
}
