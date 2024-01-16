//
//  MockData.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-12.
//

import Foundation

struct MockData {
    static var temtems: [Temtem] = [
        Temtem(number: 1,
               name: "Mimit",
               types: ["Fire"],
               wikiUrl: "",
               icon: "",
               wikiRenderStaticUrl: "",
               renderStaticImage: "")
    ]

    static var types: [TemtemType] = [
        TemtemType(name: "Fire", icon: "someURL")
    ]

    static var image: Data = Data()
}
