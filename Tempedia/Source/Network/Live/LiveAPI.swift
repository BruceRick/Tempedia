//
//  LiveAPI.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-12.
//

import Foundation

struct LiveAPI: API {
    static let baseURLString = "https://temtem-api.mael.tech"
    static let jsonDecoder: JSONDecoder = {
        var decoder = JSONDecoder()

        return decoder
    }()

    static func request<T>(endpoint: Endpoint) async throws -> (data: T, response: URLResponse) where T: Decodable {
        guard let url = fullURL(endpoint: endpoint) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.string

        let (data, response) = try await URLSession.shared.data(for: request)
        // try debugPrint(response: response, data: data)
        let decodedData = try jsonDecoder.decode(T.self, from: data)
        return (decodedData, response)
    }

    static func requestImageData(endpoint: Endpoint) async throws -> (data: Data, response: URLResponse) {
        guard let url = fullURL(endpoint: endpoint) else {
            throw APIError.invalidURL
        }

        return try await URLSession.shared.data(from: url)
    }

    static func debugPrint(response: URLResponse, data: Data) throws {
        let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: [])
        let responseFormat = "---------HTTP RESPONSE-------\n"
        let dataFormat = "--------DATA--------"
        print(responseFormat, response, dataFormat, jsonDictionary, separator: "\n", terminator: "-------------\n\n")
    }
}
