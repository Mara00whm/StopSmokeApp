//
//  URLRequest+Extension.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 06.04.2025.
//

import Foundation

extension URLRequest {
    
    func add(httpMethod: HTTPMethod) -> Self {
        map { $0.httpMethod = httpMethod.rawValue }
    }
        
    func add<Body: Encodable>(body: Body) -> Self {
        map { $0.httpBody = try? JSONEncoder().encode(body) }
    }
    
    func add(headers: [String: String]) -> Self {
        map {
            let allHTTPHeaderFields = $0.allHTTPHeaderFields ?? [:]
            let updatedAllHTTPHeaderFields = headers.merging(allHTTPHeaderFields, uniquingKeysWith: { $1 })
            $0.allHTTPHeaderFields = updatedAllHTTPHeaderFields
        }
    }
    
    private func map(_ transform: (inout Self) -> ()) -> Self {
        var request = self
        transform(&request)
        return request
    }
}
