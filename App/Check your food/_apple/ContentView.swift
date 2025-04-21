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
    @Environment(\.modelContext) var modelContext
    @Query var products: [ProductModel]

    @State private var isShowingScanSheet: Bool = false
    @State private var barcode: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(products) { product in
                        HStack {
                            AsyncImage(url: product.imageURL) { phase in
                                switch phase {
                                case .empty:
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.gray)
                                        .opacity(0.3)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                case .failure(_):
                                    Image(systemName: "xmark.octagon")
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(width: 64, height: 64, alignment: .center)
                            VStack {
                                Text(product.productNameDE)
                                Text(product.barcode)
                                Text(String(describing: product.imageURL))
                            }
                        }
                    }
                }
                ScanButton(callback: {
                    isShowingScanSheet.toggle()
                })
            }
            .navigationTitle("Groceries")
        }
        .sheet(isPresented: $isShowingScanSheet) {
            BarcodeInputView(isShowing: $isShowingScanSheet, barcode: $barcode)
        }
        .onChange(of: barcode) { oldValue, newValue in
            if oldValue == "" {
                Task {
                    if await isProductExisting(newValue) { return }
                    let (product, err) = await requestProductBy(barcode: newValue)
                    
                    guard let product = product else {
                        print("Error fetching product: \(err?.localizedDescription ?? "")")
                        return
                    }
                
                    let model = mapDtoToModel(product)
                    modelContext.insert(model)
                }
            }
        }
    }
    
    func isProductExisting(_ barcode: String) async -> Bool {
        let descriptor = FetchDescriptor<ProductModel>(
            predicate: #Predicate { $0.barcode == barcode }
        )
        
        do {
            let results = try modelContext.fetch(descriptor)
            return !results.isEmpty
        } catch {
            print("Error fetching products: \(error.localizedDescription)")
            return false
        }
    }
}

#Preview {
    ContentView()
}
