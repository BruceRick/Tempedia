//
//  TemtemListView.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-11.
//

import ComposableArchitecture
import SwiftUI

struct TemtemListView {
    @ObservedObject var viewStore: ViewStoreOf<TemtemListReducer>
    @Environment(\.horizontalSizeClass) var sizeClass

    init(store: StoreOf<TemtemListReducer>) {
        self.viewStore = ViewStore(store, observe: { $0 })
    }
}

extension TemtemListView: View {
    var body: some View {
        Group {
            switch viewStore.networkState {
            case .success, .cached:
                temtems
            case .loading, .notStarted:
                loadingView
            case .error:
                errorView
            }
        }
        .navigationTitle("Temtem")
        .onAppear { viewStore.send(.onAppear, animation: .default) }
    }

    @ViewBuilder
    var temtems: some View {
        switch sizeClass {
        case .compact:
            listTemtems
        default:
            tableTemtems
        }
    }

    var listTemtems: some View {
        List {
            ForEach(viewStore.temtems) { temtem in
                HStack {
                    Text("#\(temtem.formattedNumber)")
                    Text(temtem.name)
                }
            }
        }
    }

    var tableTemtems: some View {
        Table(viewStore.temtems) {
            TableColumn("number", value: \.formattedNumber)
            TableColumn("name", value: \.name)
        }
    }

    var loadingView: some View {
        VStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }

    var errorView: some View {
        VStack {
            Spacer()
            Text("An error occurred")
                .foregroundColor(.red)
            Spacer()
        }
    }
}

private extension Temtem {
    var formattedNumber: String {
        Formatters.temtemNumber.string(from: NSNumber(value: number)) ?? "???"
    }
}

#Preview {
  TemtemListView(
    store: Store(initialState: TemtemListReducer.State()) {
      TemtemListReducer()
    }
  )
}
