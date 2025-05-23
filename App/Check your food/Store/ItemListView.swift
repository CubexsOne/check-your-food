//
//  ItemListView.swift
//  Check your food
//
//  Created by Pascal Sauer on 01.05.25.
//

import SwiftData
import SwiftUI

struct ItemListView: View {
    @Query(
        filter: #Predicate<StoreItemModel> { $0.isDeleted == false },
        sort: \StoreItemModel.bestBefore
    )
    var storeItems: [StoreItemModel]
    @State private var isShowingScanSheet: Bool = false
    @State private var barcode: String = ""
    @State private var searchedProduct: ProductModel?
    
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
                                Text(item.product.productName)
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
            .sheet(isPresented: $isShowingScanSheet) {
                if let searchedProduct = searchedProduct {
                    AddItemView(isShowingScanSheet: $isShowingScanSheet, searchedProduct: searchedProduct)
                } else {
                    BarcodeInputView(searchedProduct: $searchedProduct)
                }
            }
            .onChange(of: isShowingScanSheet) { _, newValue in
                if newValue { return }
                searchedProduct = nil
            }
        }
        .tabItem {
            Label("Stored Items", systemImage: "bag")
        }
        .tag(TabTags.storeItemList)
    }
}
