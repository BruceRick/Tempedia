//
//  API.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-12.
//

import Foundation

public protocol API {
    static var baseURLString: String { get }

    @Sendable
    static func request<T>(endpoint: Endpoint) async throws -> (data: T, response: URLResponse) where T: Decodable
}

enum APIError: Error {
    case invalidURL
}
