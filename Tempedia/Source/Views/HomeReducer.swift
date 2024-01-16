//
//  HomeReducer.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-11.
//

import ComposableArchitecture

@Reducer
struct HomeReducer {
    struct State: Equatable {
        var path = StackState<HomePathReducer.State>()
    }

    enum Action {
        case path(StackAction<HomePathReducer.State, HomePathReducer.Action>)
    }

    var body: some Reducer<State, Action> {
        Reduce { _, action in
            switch action {
            case let .path(action):
                switch action {
                default:
                    return .none
                }
            }
        }
        .forEach(\.path, action: \.path) {
            HomePathReducer()
        }
    }
}

@Reducer
struct HomePathReducer {
    enum State: Equatable {
        case temtemList(TemtemListReducer.State = .init())
        case itemsList(ItemsListReducer.State = .init())
        case movesList(MovesListReducer.State = .init())
        case techniquesList(TechniquesListReducer.State = .init())
        case typesList(TypesListReducer.State = .init())
    }

    enum Action {
        case temtemList(TemtemListReducer.Action)
        case itemsList(ItemsListReducer.Action)
        case movesList(MovesListReducer.Action)
        case techniquesList(TechniquesListReducer.Action)
        case typesList(TypesListReducer.Action)
    }

    var body: some Reducer<State, Action> {
        Scope(state: \.temtemList, action: \.temtemList) {
            TemtemListReducer()
        }
    }
}
