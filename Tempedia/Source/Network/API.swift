//
//  API.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-12.
//

import Foundation

public protocol API {
    static var baseURLString: String { get }
    static func fullURL(endpoint: Endpoint) -> URL?

    @Sendable
    static func request<T>(endpoint: Endpoint) async throws -> (data: T, response: URLResponse) where T: Decodable

    @Sendable
    static func requestImageData(endpoint: Endpoint) async throws -> (data: Data, response: URLResponse)
}

extension API {
    public static func fullURL(endpoint: Endpoint) -> URL? {
        URL(string: Self.baseURLString + endpoint.path)?.appending(queryItems: endpoint.queryItems)
    }
}

enum APIError: Error {
    case invalidURL
}
