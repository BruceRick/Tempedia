//
//  AppReducer.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-11.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AppReducer {
    struct State: Equatable {
        var home = HomeReducer.State()
        var typesNetworkState: NetworkState = .notStarted
    }

    enum Action {
        case home(HomeReducer.Action)
        case onAppear
        case loadTypes
        case loadTypesResponse(TaskResult<(data: [TemtemType], response: URLResponse)>)
        case loadTypeImages(types: [TemtemType])
        case loadTypeImageReponse(String, TaskResult<(data: Data, response: URLResponse)>)
        case loadTypeImagesComplete
    }

    @Dependency(\.network.api) var api
    @Dependency(\.storage) var storage

    enum CancelID { case loadTypes, loadImages }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                if storage.getTypes().isEmpty {
                    return .send(.loadTypes, animation: .default)
                }

                state.typesNetworkState = .cached
                return .none
            case .loadTypes:
                state.typesNetworkState = .loading
                return .run { send in
                    await send(
                        .loadTypesResponse(
                            TaskResult { try await api().request(endpoint: .types) }
                        )
                    )
                }
                .animation(.default)
                .cancellable(id: CancelID.loadTypes)

            case .loadTypesResponse(.success((let data, _))):
                storage.storeTypes(data)
                return .send(.loadTypeImages(types: data), animation: .default)
            case .loadTypesResponse(.failure):
                state.typesNetworkState = .error
                return .none
            case .loadTypeImages(let types):
                state.typesNetworkState = .loading
                return .run { send in
                    await withTaskCancellation(id: CancelID.loadImages) {
                        for type in types {
                            await send(
                                .loadTypeImageReponse(
                                    type.name,
                                    TaskResult { try await api().requestImageData(endpoint: .image(type.icon)) }
                                )
                            )
                        }

                        await send(.loadTypeImagesComplete)
                    }
                }
                .animation(.default)
                .cancellable(id: CancelID.loadTypes)
            case .loadTypeImageReponse(let name, .success((let data, _))):
                storage.storeTypeImage(name, data)
                return .none
            case .loadTypeImageReponse(_, .failure):
                return .none
            case .loadTypeImagesComplete:
                state.typesNetworkState = .success
                return .none
            case .home:
                return .none
            }
        }

        Scope(state: \.home, action: /Action.home) {
            HomeReducer()
        }
    }
}
