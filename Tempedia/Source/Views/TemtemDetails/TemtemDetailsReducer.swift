//
//  TemtemDetailsReducer.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-15.
//

import Foundation
import ComposableArchitecture

@Reducer
struct TemtemDetailsReducer {
    struct State: Equatable {
        let temtem: Temtem
        var typeIcons: [String: Data] = [:]
    }

    enum Action {
        case onAppear
        case close
    }

    @Dependency(\.storage) var storage

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.typeIcons = storage.getTypeImages()
                return .none

            default:
                return .none
            }
        }
    }
}
