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

    @State private var isShowingScanSheet: Bool = false
    @State private var barcode: String = ""
    @State private var searchedProduct: ProductModel?

    var body: some View {
        NavigationStack {
            ZStack {
                TabView(selection: $selectedTab) {
                    ItemListView()
                    ProductListView()
                }
                .navigationTitle(getNavigationTitle())
                ScanButton(callback: {
                    isShowingScanSheet.toggle()
                })
            }
        }
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
    
    func getNavigationTitle() -> String {
        switch selectedTab {
        case .storeItemList:
            return "Groceries"
        case .productList:
            return "Products"
        }
    }
}

#Preview {
    ContentView()
}
