//
//  MockData.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-12.
//

import Foundation

struct MockData {
    static var temtems: [Temtem] = [
        temtem
    ]

    static var temtem: Temtem = .init(number: 1,
                                      name: "Oree",
                                      types: ["Fire"],
                                      traits: [],
                                      stats: .init(hp: 25,
                                                   sta: 25,
                                                   spd: 25,
                                                   atk: 25,
                                                   def: 25,
                                                   spatk: 25,
                                                   spdef: 25),
                                      tvYields: .init(hp: 1,
                                                      sta: 0,
                                                      spd: 0,
                                                      atk: 0,
                                                      def: 0,
                                                      spatk: 0,
                                                      spdef: 0),
                                      techniques: [.init(techniqueClass: "Physical",
                                                         damage: 100,
                                                         staminaCost: 26,
                                                         name: "Darkness",
                                                         source: "Leveling",
                                                         levels: 15,
                                                         type: "Mental")],
                                      evolution: .init(evolutionTree: [
                                        .init(name: "Oree",
                                              stage: 1,
                                              level: 25,
                                              trading: false,
                                              traitMapping: ["Trait1": "Trait2"]),
                                        .init(name: "Zaobian",
                                              stage: 2,
                                              level: nil,
                                              trading: nil,
                                              traitMapping: ["Trait1": "Trait2"])
                                      ]),
                                      weaknesses: [:],
                                      wikiUrl: "",
                                      icon: "",
                                      wikiRenderStaticUrl: "",
                                      renderStaticImage: "")

    static var types: [TemtemType] = [
        TemtemType(name: "Fire", icon: "someURL")
    ]

    static var image: Data = Data()
}
