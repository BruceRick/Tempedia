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
        case types
        case typeImages
        case temtemImages
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
    static func saveTypeImage(type: String, data: Data) {
        var storedTypeImages: [String: Data] = get(.typeImages) ?? [:]
        storedTypeImages[type] = data
        set(storedTypeImages, key: .typeImages)
    }

    static func saveTemtemImages(_ temtemImages: TemtemImages) {
        var allStoredTemtemImages: [TemtemImages] = get(.temtemImages) ?? []
        let storedTemtemImages = allStoredTemtemImages.first { $0.name == temtemImages.name }

        if var storedTemtemImages {
            storedTemtemImages.icon = temtemImages.icon
            storedTemtemImages.render = temtemImages.render
            storedTemtemImages.renderWiki = temtemImages.renderWiki
        } else {
            allStoredTemtemImages.append(temtemImages)
        }

        set(allStoredTemtemImages, key: .temtemImages)
    }
}
