//
//  ColorSettingsButton.swift
//  Check your food
//
//  Created by Pascal Sauer on 04.05.25.
//

import SwiftUI

struct ColorSettingsButton: View {
    var text: String
    var settingKey: String
    var settingValue: AppStorage<String>
    
    var color: Color {
        settingValue.wrappedValue.mapToColor()
    }
    
    @State private var isShowingSheet: Bool = false
    
    init(text: String, settingKey: String, defaultColor: Color) {
        self.text = text
        self.settingKey = settingKey
        self.settingValue = AppStorage<String>(wrappedValue: defaultColor.mapToString(), settingKey)
    }

    var body: some View {
        HStack {
            Text(text)
            Spacer()
            Circle()
                .fill(color)
                .frame(width: 16, height: 16)
            Image(systemName: "chevron.right")
                .opacity(0.5)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isShowingSheet.toggle()
        }
        .accessibilityLabel("\(text) color")
        .accessibilityHint("Tap to change the color for \(text). Current color: \(color.description)")
        .sheet(isPresented: $isShowingSheet) {
            VStack {
                HStack {
                    Text(text)
                        .font(.headline)
                }
                .padding(.top, 32)
                Spacer()
                LazyVGrid(columns: Array(repeating: GridItem(.fixed(64), spacing: 8), count: 4), spacing: 48) {
                    ForEach(availableColors, id: \.self) { color in
                        Circle()
                            .fill(color)
                            .frame(width: 32, height: 32)
                            .contentShape(Circle())
                            .onTapGesture {
                                settingValue.wrappedValue = color.mapToString()
                                isShowingSheet.toggle()
                            }
                            .accessibilityLabel(color.description)
                            .accessibilityHint("Tap to select the color \(color.description) for \(text).")
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 200)
                .presentationDetents([.fraction(0.3)])
            }
        }
    }
}
