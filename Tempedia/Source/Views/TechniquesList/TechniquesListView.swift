//
//  TechniquesListView.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-11.
//

import ComposableArchitecture
import SwiftUI

struct TechniquesListView: View {
    let store: StoreOf<TechniquesListReducer>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { _ in
            VStack {
                Spacer()
                Text("Techniques")
                Spacer()
            }
        }
        .navigationTitle("Techniques")
    }
}
