//
//  Formatters.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-12.
//

import Foundation

struct Formatters {
    static var temtemNumber: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 3
        return formatter
    }()

    static var weaknesses: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 2
        return formatter
    }()
}
