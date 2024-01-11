//
//  TypesListView.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-11.
//

import ComposableArchitecture
import SwiftUI

struct TypesListView: View {
    let store: StoreOf<TypesListReducer>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { _ in
            VStack {
                Spacer()
                Text("Types")
                Spacer()
            }
        }
        .navigationTitle("Types")
    }
}
