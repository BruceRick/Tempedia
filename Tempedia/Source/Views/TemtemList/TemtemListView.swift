//
//  TemtemListView.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-11.
//

import ComposableArchitecture
import SwiftUI

struct TemtemListView: View {
    let store: StoreOf<TemtemListReducer>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { _ in
            VStack {
                Spacer()
                Text("TemTem")
                Spacer()
            }
        }
        .navigationTitle("Temtem")
    }
}
