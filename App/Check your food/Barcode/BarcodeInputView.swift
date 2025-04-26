//
//  BarcodeInputView.swift
//  Check your food
//
//  Created by Pascal Sauer on 21.04.25.
//

import CodeScanner
import SwiftUI

struct BarcodeInputView: View {
    @State private var isShowingAlert: Bool = false
    @State private var alertMessage: String = ""
    
    @Binding var barcode: String

    var body: some View {
        CodeScannerView(
            codeTypes: [.ean8, .ean13],
            showViewfinder: true,
            simulatedData: "4062139025398",
            completion: handleScan
        )
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("Scan Error"), message: Text(alertMessage), dismissButton: .default(Text("OK!")))
        }
    }
    
    func handleScan(scanResult: Result<ScanResult, ScanError>) {
        switch scanResult {
        case .success(let result):
            barcode = result.string
        case .failure(let error):
            alertMessage = error.localizedDescription
            isShowingAlert = true
        }
    }
}
