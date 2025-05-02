//
//  ProductList.swift
//  Check your food
//
//  Created by Pascal Sauer on 01.05.25.
//

import SwiftData
import SwiftUI

struct ProductListView: View {
    @Environment(\.modelContext) var modelContext

    @State private var searchText: String = ""
    @Query(sort: [SortDescriptor(\ProductModel.productName)]) private var products: [ProductModel]
    
    var filteredProducts: [ProductModel] {
        if searchText.isEmpty {
            return products
        } else {
            return products.filter {
                $0.productName.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(filteredProducts) { product in
                        NavigationLink(destination: {
                            ProductEditView(product: product)
                        }) {
                            HStack {
                                ProductImage(product: product)
                                    .frame(width: 64, height: 64)
                                Divider()
                                VStack(alignment: .leading) {
                                    Text(product.productName)
                                        .font(.caption)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Products")
            .searchable(text: $searchText, prompt: "Search products")
        }
        .tabItem {
            Label("Products", systemImage: "list.dash")
        }
        .tag(TabTags.productList)
    }
}
