//
//  Database.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-12.
//

import Foundation

struct Storage {
    enum Key: String {
        case temtem
    }

    static let defaults = UserDefaults.standard
    static let encoder = JSONEncoder()
    static let decoder = JSONDecoder()

    static func set<T: Encodable>(_ value: T?, key: Storage.Key) {
        if let encoded = try? encoder.encode(value) {
            defaults.set(encoded, forKey: key.rawValue)
        }
    }

    static func get<T: Codable>(_ key: Storage.Key) -> T? {
        guard let value = defaults.object(forKey: key.rawValue) as? Data else {
            return nil
        }

        return try? decoder.decode(T.self, from: value)
    }
}

extension Storage {
    static var temtem: [Temtem] = get(.temtem) ?? []

    static func saveTemtem(data: [Temtem]) {
        set(data, key: .temtem)
    }
}
