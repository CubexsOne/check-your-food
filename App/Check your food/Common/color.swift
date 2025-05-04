//
//  color.swift
//  Check your food
//
//  Created by Pascal Sauer on 04.05.25.
//

import SwiftUI

let availableColors: [Color] = [.blue, .brown, .cyan, .green, .mint, .orange, .red, .yellow]

extension Color {
    func mapToString() -> String {
        switch self {
        case .blue:
            return "blue"
        case .brown:
            return "brown"
        case .cyan:
            return "cyan"
        case .green:
            return "green"
        case .mint:
            return "mint"
        case .orange:
            return "orange"
        case .red:
            return "red"
        case .yellow:
            return "yellow"
        default:
            return "gray"
        }
    }
}

extension String {
    func mapToColor() -> Color {
        switch self {
        case "blue":
            return .blue
        case "brown":
            return .brown
        case "cyan":
            return .cyan
        case "green":
            return .green
        case "mint":
            return .mint
        case "orange":
            return .orange
        case "red":
            return .red
        case "yellow":
            return .yellow
        default:
            return .gray
        }
    }
}
