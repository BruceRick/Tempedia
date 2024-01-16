//
//  Endpoint.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-12.
//

import Foundation

public enum Endpoint {
    case temtems
    case types
    case image(String)

    var path: String {
        switch self {
        case .temtems:
            return "/api/temtems"
        case .types:
            return "/api/types"
        case .image(let path):
            return path
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
}

enum HTTPMethod {
    case get

    var string: String {
        switch self {
        case .get:
            return "GET"
        }
    }
}
