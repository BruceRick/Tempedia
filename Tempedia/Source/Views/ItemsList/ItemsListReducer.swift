//
//  ItemsListReducer.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-11.
//

import ComposableArchitecture

@Reducer
struct ItemsListReducer {
    struct State: Codable, Equatable, Hashable { }

    enum Action {
        case onAppear
    }

    var body: some Reducer<State, Action> {
        Reduce { _, action in
            switch action {
            default:
                return .none
            }
        }
    }
}
