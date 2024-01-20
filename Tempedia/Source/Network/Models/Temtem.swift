//
//  Temtem.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-12.
//

import Foundation

public struct Temtem: Codable, Equatable, Identifiable {
    public var id: Int { number }

    let number: Int
    let name: String
    let types: [String]
    let traits: [Trait]
    let stats: Stats
    let tvYields: Stats
    let techniques: [Technique]
    let evolution: Evolutions
    let weaknesses: [String: Float]
    let wikiUrl: String
    let icon: String
    let wikiRenderStaticUrl: String
    let renderStaticImage: String

    // swiftlint:disable identifier_name
    struct Stats: Codable, Equatable {
        let hp: Int
        let sta: Int
        let spd: Int
        let atk: Int
        let def: Int
        let spatk: Int
        let spdef: Int
    }
    // swiftlint:enable identifier_name

    struct Technique: Codable, Equatable {
        private enum CodingKeys: String, CodingKey {
            case techniqueClass = "class", damage, staminaCost, name, source, levels, type
        }

        let techniqueClass: String
        let damage: Int
        let staminaCost: Int
        let name: String
        let source: String
        let levels: Int?
        let type: String
    }

    struct Evolutions: Codable, Equatable {
        let evolutionTree: [Evolution]?
    }

    struct Evolution: Codable, Equatable {
        let name: String
        let stage: Int
        let level: Int?
        let trading: Bool?
        let traitMapping: [String: String]
    }

    struct Trait: Codable, Equatable {
        let name: String?
        let description: String?
        let wikiUrl: String?
        let effect: String?
    }
}
