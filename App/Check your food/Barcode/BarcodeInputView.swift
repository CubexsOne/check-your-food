//
//  BarcodeInputView.swift
//  Check your food
//
//  Created by Pascal Sauer on 21.04.25.
//

import CodeScanner
import SwiftUI

struct BarcodeInputView: View {
    @Environment(\.modelContext) var modelContext

    @State private var barcode: String = ""
    @State private var isShowingAlert: Bool = false
    @State private var alertMessage: String = ""

    @Binding var searchedProduct: ProductModel?

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
        .onChange(of: barcode) { oldValue, newValue in
            if oldValue == "" {
                barcode = ""
                if let product = getProductBy(barcode: newValue, modelContext) {
                    searchedProduct = product
                    return
                }

                Task {
                    let (productDto, productDtoError) = await requestProductBy(barcode: newValue)
                    guard let productDto = productDto else {
                        print("Error fetching product: \(productDtoError?.localizedDescription ?? "")")
                        return
                    }
                    
                    let (image, imageError) = await downloadProductImageBy(url: productDto.product.imageUrl)
                    if image == nil {
                        print("Error downloading image: \(imageError?.localizedDescription ?? "")")
                    }
                    
                    let productModel = mapDtoToModel(dto: productDto, image: image)
                    searchedProduct = productModel
                    modelContext.insert(productModel)
                }
            }
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
