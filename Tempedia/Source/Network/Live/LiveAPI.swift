//
//  LiveAPI.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-12.
//

import Foundation

struct LiveAPI: API {
    static let baseURLString = "https://temtem-api.mael.tech/api/"
    static let jsonDecoder: JSONDecoder = {
        var decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    static func request<T>(endpoint: Endpoint) async throws -> (data: T, response: URLResponse) where T: Decodable {
        guard let url = URL(string: Self.baseURLString + endpoint.path) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.string

        let (data, response) = try await URLSession.shared.data(for: request)
        let decodedData = try jsonDecoder.decode(T.self, from: data)
        return (decodedData, response)
    }
}
