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

    var body: some View {
        VStack {
            List {
                ForEach(products) { product in
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
        .tabItem {
            Label("Products", systemImage: "list.dash")
        }
        .tag(TabTags.productList)
    }
}
