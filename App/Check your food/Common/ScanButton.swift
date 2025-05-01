//
//  ScanButton.swift
//  Check your food
//
//  Created by Pascal Sauer on 21.04.25.
//

import SwiftUI

struct ScanButton: View {
    var callback: () -> Void

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button(action: {
                    callback()
                }) {
                    Image(systemName: "qrcode.viewfinder")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .accessibilityLabel("Scan Barcode")
                .padding()
            }
        }
    }
}
