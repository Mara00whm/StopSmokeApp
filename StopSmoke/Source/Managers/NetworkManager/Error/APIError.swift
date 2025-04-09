//
//  APIError.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 05.04.2025.
//

import Foundation

enum APIError: Error {
    case networkError(Error)
    case decoding
    case invalidUrl
    case invalidResponse
    case statusCode(Int)
}
