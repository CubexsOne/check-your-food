//
//  ItemStatus.swift
//  Check your food
//
//  Created by Pascal Sauer on 01.05.25.
//

import SwiftUI

struct ItemStatus: View {
    @AppStorage("moreThanThreeDaysBefore") var moreThanThreeDaysBefore: String = Color.green.mapToString()
    @AppStorage("threeDaysBefore") var threeDaysBefore: String = Color.yellow.mapToString()
    @AppStorage("sameDayOrLater") var sameDayOrLater: String = Color.orange.mapToString()

    let bestBefore: Date
    private let today = Date()

    var body: some View {
        Circle()
            .fill(getStatusColor())
            .frame(width: 16, height: 16)
            .accessibilityLabel("Best-Before date status indicator")
            .accessibilityHint("The color indicates the status of the best-before date: \(moreThanThreeDaysBefore) for safe consumption, \(threeDaysBefore) for warning it expires soon, \(sameDayOrLater) for caution could have expired")
    }
    
    func getStatusColor() -> Color {
        let calendar = Calendar.current
        
        let daysDifference = calendar.dateComponents([.day], from: calendar.startOfDay(for: today), to: calendar.startOfDay(for: bestBefore)).day ?? 0
        
        switch daysDifference {
        case let x where x > 3:
            return moreThanThreeDaysBefore.mapToColor()
        case 1...3:
            return threeDaysBefore.mapToColor()
        default:
            return sameDayOrLater.mapToColor()
        }
    }
}
