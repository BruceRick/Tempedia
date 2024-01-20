//
//  TemtemListReducer.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-11.
//

import Foundation
import ComposableArchitecture

@Reducer
struct TemtemListReducer {
    struct State: Equatable {
        var networkState: NetworkState = .notStarted
        var temtems: [Temtem] = []
        var typeIcons: [String: Data] = [:]
        @BindingState var searchText: String = ""

        var filteredTemtems: [Temtem] {
            if searchText.isEmpty {
                return temtems
            } else {
                return temtems.filter { $0.name.contains(searchText) }
            }
        }
    }

    enum Action: BindableAction {
        case onAppear
        case loadTemtem
        case loadTemtemResponse(TaskResult<(data: [Temtem], response: URLResponse)>)
        case didSelect(Temtem)
        case binding(BindingAction<State>)
    }

    @Dependency(\.network.api) var api
    @Dependency(\.storage) var storage

    enum CancelID { case loadTemtem }

    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.typeIcons = storage.getTypeImages()
                state.temtems = storage.getTemtem()
                state.networkState = state.temtems.isEmpty ? state.networkState : .cached
                if state.temtems.isEmpty {
                    return .send(.loadTemtem, animation: .default)
                }

                return .none
            case .loadTemtem:
                state.networkState = .loading
                return .run { send in
                    await send(
                        .loadTemtemResponse(
                            TaskResult { try await api().request(endpoint: .temtems) }
                        )
                    )
                }
                .animation(.default)
                .cancellable(id: CancelID.loadTemtem)

            case .loadTemtemResponse(.success((let data, _))):
                state.temtems = data
                storage.storeTemtem(data)
                state.networkState = .success
                return .none

            case .loadTemtemResponse(.failure):
                state.temtems = storage.getTemtem()
                state.networkState = state.temtems.isEmpty ? .error : .cached
                return .none

            case .didSelect:
                return .none

            case .binding:
                return .none
            }
        }
    }
}
