//
//  Endpoint.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 05.04.2025.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var request: Encodable? { get }
}
