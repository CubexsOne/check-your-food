//
//  ContentView.swift
//  Check your food
//
//  Created by Pascal Sauer on 20.04.25.
//

import BarcodeView
import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var selectedTab: TabTags = .storeItemList

    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                ItemListView()
                ProductListView()
                SettingsView()
            }
        }
    }
}

#Preview {
    ContentView()
}
