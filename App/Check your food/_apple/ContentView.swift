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
                            Spacer()
                            ItemStatus(bestBefore: item.bestBefore)
                        }
                    }
                    .onDelete { offsets in
                        for offset in offsets {
                            storeItems[offset].isDeleted = true
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
                AddItemView(selectedDate: $selectedDate, isShowingScanSheet: $isShowingScanSheet, searchedProduct: searchedProduct)
            } else {
                BarcodeInputView(barcode: $barcode, searchedProduct: $searchedProduct)
            }
        }
        .onChange(of: isShowingScanSheet) { _, newValue in
            if newValue { return }
            searchedProduct = nil
        }
    }
}

#Preview {
    ContentView()
}
