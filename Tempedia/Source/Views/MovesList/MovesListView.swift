//
//  MovesListView.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-11.
//

import ComposableArchitecture
import SwiftUI

struct MovesListView: View {
    let store: StoreOf<MovesListReducer>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { _ in
            VStack {
                Spacer()
                Text("Moves")
                Spacer()
            }
        }
        .navigationTitle("Moves")
    }
}
