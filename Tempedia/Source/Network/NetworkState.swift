//
//  NetworkState.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-12.
//

import Foundation

enum NetworkState: Equatable {
    case notStarted
    case cached
    case success
    case error
    case loading
}
