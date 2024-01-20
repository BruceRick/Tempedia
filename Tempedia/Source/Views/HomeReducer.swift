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
        var temtemDetails: TemtemDetailsReducer.State?
    }

    enum Action {
        case path(StackAction<HomePathReducer.State, HomePathReducer.Action>)
        case temtemDetails(TemtemDetailsReducer.Action)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .path(action):
                switch action {
                case .element(id: _, action: .temtemList(.didSelect(let temtem))):
                    state.temtemDetails = .init(temtem: temtem)
                    return .none

                default:
                    return .none
                }

            case .temtemDetails(.close):
                state.temtemDetails = nil
                return .none

            case .temtemDetails:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            HomePathReducer()
        }

        .ifLet(\.temtemDetails, action: /Action.temtemDetails) {
            TemtemDetailsReducer()
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
