//
//  AppReducer.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-11.
//

import ComposableArchitecture

@Reducer
struct AppReducer {
    struct State {
        var home = HomeReducer.State()
    }

    enum Action {
        case home(HomeReducer.Action)
    }

    var body: some Reducer<State, Action> {
        Reduce { _, action in
            switch action {
            case .home:
                return .none
            }
        }

        Scope(state: \.home, action: /Action.home) {
            HomeReducer()
        }
    }
}
