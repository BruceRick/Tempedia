//
//  MockAPI.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-12.
//

import Foundation

struct MockAPI: API {
    static let baseURLString = "https://mock-api-url.com/"
    static let throttleDurationSeconds = 0

    static func request<T>(endpoint: Endpoint) async throws -> (data: T, response: URLResponse) where T: Decodable {
        try await Task.sleep(nanoseconds: throttleDurationNanosecond)

        guard let url = URL(string: Self.baseURLString + endpoint.path) else {
            throw APIError.invalidURL
        }

        guard let mock = endpoint.mock as? T else {
            throw APIError.invalidURL
        }

        return (mock, .init(url: url,
                            mimeType: "mockMIME",
                            expectedContentLength: 100,
                            textEncodingName: "MockTextEndcoding"))
    }
}

private extension Endpoint {
    var mock: Decodable {
        switch self {
        case .temtems:
            return MockData.temtems
        }
    }
}

extension MockAPI {
  static let nanosecondMultiplier = 1_000_000_000
  static var throttleDurationNanosecond: UInt64 { UInt64(throttleDurationSeconds * nanosecondMultiplier) }
}
