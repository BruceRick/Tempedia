//
//  ItemsListView.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-11.
//

import ComposableArchitecture
import SwiftUI

struct ItemsListView: View {
    let store: StoreOf<ItemsListReducer>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { _ in
            VStack {
                Spacer()
                Text("Items")
                Spacer()
            }
        }
        .navigationTitle("Items")
    }
}
