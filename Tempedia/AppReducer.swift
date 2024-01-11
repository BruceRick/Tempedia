//
//  AppReducer.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-11.
//

import ComposableArchitecture

struct AppReducer: Reducer {
    struct State { }

    enum Action {
        case mainNavigation
    }

    var body: some Reducer<State, Action> {
        Reduce { _, action in
            switch action {
            case .mainNavigation:
                return .none
            }
        }
    }
}
