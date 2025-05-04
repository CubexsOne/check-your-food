//
//  SettingsView.swift
//  Check your food
//
//  Created by Pascal Sauer on 03.05.25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Section {
                ColorSettingsButton(text: "More than 3 days before", settingKey: "moreThanThreeDaysBefore", defaultColor: Color.green)
                ColorSettingsButton(text: "3 days before", settingKey: "threeDaysBefore", defaultColor: Color.yellow)
                ColorSettingsButton(text: "Same day or later", settingKey: "sameDayOrLater", defaultColor: Color.orange)
            } header: {
                Text("Status indicators")
            }
        }
        .tabItem {
            Label("Settings", systemImage: "gear")
        }
        .tag(TabTags.settings)
    }
}
