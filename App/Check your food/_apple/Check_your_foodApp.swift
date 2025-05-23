//
//  Check_your_foodApp.swift
//  Check your food
//
//  Created by Pascal Sauer on 20.04.25.
//

import SwiftData
import SwiftUI

@main
struct Check_your_foodApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [ProductModel.self, StoreItemModel.self])
    }
}
