//
//  AppView.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-11.
//

import ComposableArchitecture
import SwiftUI

struct AppView {
    typealias State = AppReducer.State
    typealias Action = AppReducer.Action

    var store: StoreOf<AppReducer>
}

extension AppView: View {
    var body: some View {
        HomeView(store: store.scope(
            state: \.home,
            action: AppReducer.Action.home
        ))
    }
}

#Preview {
  AppView(
    store: Store(initialState: AppReducer.State()) {
      AppReducer()
    }
  )
}
