//
//  HomeView.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-11.
//

import ComposableArchitecture
import SwiftUI

struct HomeView: View {
    let store: StoreOf<HomeReducer>

    var body: some View {
        NavigationStackStore(self.store.scope(state: \.path, action: \.path)) {
            List {
                NavigationLink(
                    "Temtem",
                    state: HomePathReducer.State.temtemList()
                )
                NavigationLink(
                    "Items",
                    state: HomePathReducer.State.itemsList()
                )
                NavigationLink(
                    "Moves",
                    state: HomePathReducer.State.movesList()
                )
                NavigationLink(
                    "Techniques",
                    state: HomePathReducer.State.techniquesList()
                )
                NavigationLink(
                    "Types",
                    state: HomePathReducer.State.typesList()
                )
            }
            .navigationTitle("Tempedia")
        } destination: {
            switch $0 {
            case .temtemList:
                CaseLet(
                    \HomePathReducer.State.temtemList,
                    action: HomePathReducer.Action.temtemList,
                    then: TemtemListView.init(store:)
                )
            case .itemsList:
                CaseLet(
                    \HomePathReducer.State.itemsList,
                    action: HomePathReducer.Action.itemsList,
                    then: ItemsListView.init(store:)
                )
            case .movesList:
                CaseLet(
                    \HomePathReducer.State.movesList,
                    action: HomePathReducer.Action.movesList,
                    then: MovesListView.init(store:)
                )
            case .techniquesList:
                CaseLet(
                    \HomePathReducer.State.techniquesList,
                    action: HomePathReducer.Action.techniquesList,
                    then: TechniquesListView.init(store:)
                )
            case .typesList:
                CaseLet(
                    \HomePathReducer.State.typesList,
                    action: HomePathReducer.Action.typesList,
                    then: TypesListView.init(store:)
                )
            }
        }
    }
}

#Preview {
  HomeView(
    store: Store(initialState: HomeReducer.State()) {
      HomeReducer()
    }
  )
}
