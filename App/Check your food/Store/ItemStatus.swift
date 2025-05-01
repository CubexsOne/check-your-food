//
//  ItemStatus.swift
//  Check your food
//
//  Created by Pascal Sauer on 01.05.25.
//

import SwiftUI

struct ItemStatus: View {
    let bestBefore: Date
    private let today = Date()

    var body: some View {
        Circle()
            .fill(getStatusColor())
            .frame(width: 16, height: 16)
            .accessibilityLabel(Text("Best-Before date status indicator"))
            .accessibilityHint(Text("Color indicates the status of the best-before date: green for safe consumption, yellow for caution, red for expired"))
    }
    
    func getStatusColor() -> Color {
        let calendar = Calendar.current
        
        let daysDifference = calendar.dateComponents([.day], from: calendar.startOfDay(for: today), to: calendar.startOfDay(for: bestBefore)).day ?? 0
        
        switch daysDifference {
        case let x where x > 3:
            return .green
        case 1...3:
            return .yellow
        default:
            return .red
        }
    }
}
