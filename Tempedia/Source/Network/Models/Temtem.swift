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
    let wikiUrl: String
    let icon: String
    let wikiRenderStaticUrl: String
    let renderStaticImage: String
}
