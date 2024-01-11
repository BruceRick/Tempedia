//
//  TempediaApp.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-11.
//

import ComposableArchitecture
import SwiftUI

@main
struct TempediaApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(
                store: Store(initialState: AppReducer.State()) {
                  AppReducer()
                }
            )
        }
    }
}
