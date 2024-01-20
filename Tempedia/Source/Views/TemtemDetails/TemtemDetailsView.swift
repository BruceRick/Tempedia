//
//  TemtemDetailsView.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-15.
//

import ComposableArchitecture
import SwiftUI

struct TemtemDetailsView {
    @ObservedObject var viewStore: ViewStoreOf<TemtemDetailsReducer>

    var namespace: Namespace.ID

    init(store: StoreOf<TemtemDetailsReducer>, namespace: Namespace.ID) {
        self.viewStore = ViewStore(store, observe: { $0 })
        self.namespace = namespace
    }
}

extension TemtemDetailsView: View {
    var body: some View {
        NavigationView {
            List {
                image
                wiki
                types
                typeMatchup
                traits
                stats
                tvYields
                techniques
                evolutions
            }
            //        .matchedGeometryEffect(id: "View-\(viewStore.temtem.name)",
            //                               in: namespace,
            //                               properties: [.frame, .position, .size])
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .onAppear {
                viewStore.send(.onAppear)
            }
            .navigationTitle(viewStore.temtem.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button(action: {
                    viewStore.send(.close, animation: .default)
                }, label: {
                    Image(systemName: "xmark")
                })
            }
        }
        .transition(.move(edge: .bottom))
    }

    var image: some View {
        Section {
            HStack {
                Spacer()
                TemtemImageView(temtem: viewStore.temtem)
                    .frame(width: 200, height: 200)
//                        .matchedGeometryEffect(id: "Image-\(viewStore.temtem.name)",
//                                               in: namespace,
//                                               properties: [.frame, .position, .size])
                Spacer()
            }
        }
    }

    @ViewBuilder
    var wiki: some View {
        if let wiki = URL(string: viewStore.temtem.wikiUrl) {
            Section {
                Link(viewStore.temtem.wikiUrl, destination: wiki)
            }
        }
    }

    var types: some View {
        Section("Types") {
            HStack {
                ForEach(viewStore.temtem.types, id: \.self) { type in
                    if let data = viewStore.typeIcons[type],
                       let image = UIImage(data: data) {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 30, height: 30)
                    } else {
                        Text(type)
                    }
                }
            }
        }
    }

    var typeMatchup: some View {
        Section("Type Matchup") {
            ForEach(viewStore.temtem.typeMatchups().sorted { $0.key < $1.key }, id: \.key) { key, value in
                if key != 1.0 {
                    HStack {
                        Text("\(Formatters.weaknesses.string(from: NSNumber(value: key)) ?? "0") X")
                        Spacer()
                        ForEach(value, id: \.self) { type in
                            HStack {
                                if let data = viewStore.typeIcons[type],
                                   let image = UIImage(data: data) {
                                    Image(uiImage: image)
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                } else {
                                    Text(type)
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    var traits: some View {
        Section("Traits") {
            ForEach(viewStore.temtem.traits.filter { $0.name != nil }, id: \.name) { trait in
                if let traitName = trait.name {
                    VStack(alignment: .leading) {
                        Text(traitName)
                        if let traitEffect = trait.effect {
                            HStack(alignment: .top) {
                                Text("  - ")
                                Text(traitEffect)
                            }
                        }
                    }
                }
            }
        }
    }

    var stats: some View {
        Section("Stats") {
            HStack {
                Text("HP:")
                Spacer()
                Text("\(viewStore.temtem.stats.hp)")
            }
            HStack {
                Text("Stamina:")
                Spacer()
                Text("\(viewStore.temtem.stats.sta)")
            }
            HStack {
                Text("Speed:")
                Spacer()
                Text("\(viewStore.temtem.stats.spd)")
            }
            HStack {
                Text("Attack:")
                Spacer()
                Text("\(viewStore.temtem.stats.atk)")
            }
            HStack {
                Text("Defense:")
                Spacer()
                Text("\(viewStore.temtem.stats.def)")
            }
            HStack {
                Text("Special Attack:")
                Spacer()
                Text("\(viewStore.temtem.stats.spatk)")
            }
            HStack {
                Text("Special Defense:")
                Spacer()
                Text("\(viewStore.temtem.stats.spdef)")
            }
            HStack {
                Text("Total:")
                Spacer()
                Text("\(viewStore.temtem.stats.total)")
            }
        }
    }

    var tvYields: some View {
        Section("TV Yield") {
            if viewStore.temtem.tvYields.hp > 0 {
                HStack {
                    Text("HP:")
                    Spacer()
                    Text("\(viewStore.temtem.tvYields.hp)")
                }
            }
            if viewStore.temtem.tvYields.sta > 0 {
                HStack {
                    Text("Stamina:")
                    Spacer()
                    Text("\(viewStore.temtem.tvYields.sta)")
                }
            }
            if viewStore.temtem.tvYields.spd > 0 {
                HStack {
                    Text("Speed:")
                    Spacer()
                    Text("\(viewStore.temtem.tvYields.spd)")
                }
            }
            if viewStore.temtem.tvYields.atk > 0 {
                HStack {
                    Text("Attack:")
                    Spacer()
                    Text("\(viewStore.temtem.tvYields.atk)")
                }
            }
            if viewStore.temtem.tvYields.def > 0 {
                HStack {
                    Text("Defense:")
                    Spacer()
                    Text("\(viewStore.temtem.tvYields.def)")
                }
            }
            if viewStore.temtem.tvYields.spatk > 0 {
                HStack {
                    Text("Special Attack:")
                    Spacer()
                    Text("\(viewStore.temtem.tvYields.spatk)")
                }
            }
            if viewStore.temtem.tvYields.spdef > 0 {
                HStack {
                    Text("Special Defense:")
                    Spacer()
                    Text("\(viewStore.temtem.tvYields.spdef)")
                }
            }
        }
    }

    var techniques: some View {
        Section("Techniques") {
            ForEach(viewStore.temtem.techniques, id: \.name) { technique in
                VStack {
                    HStack {
                        Text(technique.name)
                        Spacer()
                        Text(technique.techniqueClass)
                    }
                    HStack {
                        Text("Stamina: \(technique.staminaCost) Damage: \(technique.damage)")
                        Spacer()
                    }
                    HStack {
                        Text(technique.source)
                        if let levels = technique.levels {
                            Text("Level: ")
                            Text("\(levels)")
                        }
                        Spacer()
                    }
                }
            }
        }
    }

    @ViewBuilder
    var evolutions: some View {
        if let evolutions = viewStore.temtem.evolution.evolutionTree {
            Section("Evolutions") {
                ForEach(evolutions, id: \.name) { evolution in
                    VStack {
                        HStack {
                            Text("Name: ")
                            Text(evolution.name)
                            Spacer()
                        }
                        HStack {
                            Text("Stage: ")
                            Text("\(evolution.stage)")
                            Spacer()
                        }
                        if let level = evolution.level, level > 0 {
                            HStack {
                                Text("Level: ")
                                Text("\(level)")
                                Spacer()
                            }
                        }
                        if let trading = evolution.trading, trading == true {
                            HStack {
                                Text("Trading Required")
                                Spacer()
                            }
                        }
                        ForEach(evolution.traitMapping.sorted(by: >), id: \.key) { key, value in
                            HStack {
                                Text("\(key) -> \(value)")
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
    }
}

private extension Temtem.Stats {
    var total: Int {
        hp + sta + spd + atk + def + spatk + spdef
    }
}

private extension Temtem {
    func typeMatchups() -> [Float: [String]] {
        Dictionary(grouping: weaknesses, by: { $0.value }).mapValues { $0.map { $0.key } }
    }
}

#Preview {
    TemtemDetailsView(
        store: Store(initialState: TemtemDetailsReducer.State(temtem: MockData.temtem)) {
            TemtemDetailsReducer()
        },
        namespace: Namespace().wrappedValue
    )
}
