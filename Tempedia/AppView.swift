//
//  AppView.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-11.
//

import ComposableArchitecture
import SwiftUI

struct AppView {
    let store: StoreOf<AppReducer>
    @ObservedObject var viewStore: ViewStoreOf<AppReducer>
    @Environment(\.horizontalSizeClass) var sizeClass

    init(store: StoreOf<AppReducer>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
}

extension AppView: View {
    var body: some View {
        Group {
            switch viewStore.typesNetworkState {
            case .notStarted, .loading:
                VStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            default:
                HomeView(store: store.scope(
                    state: \.home,
                    action: AppReducer.Action.home
                ))
            }
        }
        .onAppear {
            viewStore.send(.onAppear, animation: .default)
        }
    }
}

#Preview {
  AppView(
    store: Store(initialState: AppReducer.State()) {
      AppReducer()
    }
  )
}
