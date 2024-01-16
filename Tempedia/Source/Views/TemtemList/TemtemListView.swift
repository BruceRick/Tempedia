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
        .toolbar {
            Button {
                viewStore.send(.loadTemtem, animation: .default)
            } label: {
                HStack(spacing: 5) {
                    Image(systemName: "square.and.arrow.down")
                        .font(.system(size: 16, weight: .medium))
                    Text("Update")
                }
            }
        }
        .searchable(text: viewStore.$searchText, placement: .navigationBarDrawer(displayMode: .always))
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
            ForEach(viewStore.filteredTemtems) { temtem in
                HStack {
                    Text("#\(temtem.formattedNumber)")
                        .frame(minWidth: 50)
                    TemtemImageView(temtem: temtem)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                    Text(temtem.name)
                    Spacer()
                    ForEach(temtem.types, id: \.self) { type in
                        if let data = viewStore.typeIcons[type],
                           let image = UIImage(data: data) {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 30, height: 30)
                        } else {
                            Text(type)
                        }
                    }
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
