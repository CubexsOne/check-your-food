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
    @Query(
        filter: #Predicate<StoreItem> { $0.isDeleted == false },
        sort: \StoreItem.bestBefore
    )
    var storeItems: [StoreItem]

    @State private var isShowingScanSheet: Bool = false
    @State private var barcode: String = ""
    @State private var searchedProduct: ProductModel?
    @State private var selectedDate: Date = Calendar.current.startOfDay(for: Date())
    
    private var languageCode = Locale.current.language.languageCode?.identifier

    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(storeItems) { item in
                        HStack {
                            ProductImage(product: item.product)
                                .frame(width: 64, height: 64)
                            Divider()
                            VStack(alignment: .leading) {
                                Text(languageCode == "de" ? item.product.productNameDE : item.product.productNameEN)
                                    .font(.caption)
                                Text(item.bestBefore.formatted(date: .long, time: .omitted))
                                    .font(.subheadline)
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
            if let searchedProduct = searchedProduct {
                Form {
                    Section {
                        ProductImage(product: searchedProduct)
                        Text(languageCode == "de" ? searchedProduct.productNameDE : searchedProduct.productNameEN)
                            .font(.caption)
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                    }
                    
                    Section {
                        DatePicker("Best-Before date", selection: $selectedDate, displayedComponents: [.date])
                    }
                }

                HStack {
                    Button("Save") {
                        let item = StoreItem(bestBefore: selectedDate, product: searchedProduct)
                        modelContext.insert(item)
                        isShowingScanSheet.toggle()
                    }
                    .buttonStyle(.bordered)
                    Button("Cancel", role: .cancel) {
                        isShowingScanSheet.toggle()
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.bottom, 32)
            } else {
                BarcodeInputView(barcode: $barcode)
            }
        }
        .onChange(of: isShowingScanSheet) { _, newValue in
            if newValue { return }
            searchedProduct = nil
        }
        .onChange(of: barcode) { oldValue, newValue in
            if oldValue == "" {
                barcode = ""
                if let product = getProductBy(barcode: newValue, modelContext) {
                    searchedProduct = product
                    return
                }

                Task {
                    let (productDto, err) = await requestProductBy(barcode: newValue)
                    guard let productDto = productDto else {
                        print("Error fetching product: \(err?.localizedDescription ?? "")")
                        return
                    }
                    
                    let productModel = mapDtoToModel(productDto)
                    searchedProduct = productModel
                    modelContext.insert(productModel)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
