//
//  ProductEditView.swift
//  Check your food
//
//  Created by Pascal Sauer on 01.05.25.
//

import SwiftData
import SwiftUI

struct ProductEditView: View {
    @Environment(\.modelContext) var modelContext
    
    @Bindable var product: ProductModel
    @Query(filter: #Predicate<StoreItemModel> { $0.isDeleted == false }) var storeItems: [StoreItemModel] = []
    private var relatedItems: [StoreItemModel] {
        var filteredItems: [StoreItemModel] = []
        for item in storeItems {
            if item.product.id != product.id { continue }
            filteredItems.append(item)
        }
        return filteredItems
    }


    var body: some View {
        Form {
            Section {
                ProductImage(product: product)
                TextField("Product name", text: $product.productName)
            }
            if !storeItems.isEmpty {
                Section {
                    List {
                        ForEach(relatedItems) { item in
                            Text(item.bestBefore.formatted(date: .complete, time: .omitted))
                        }
                    }
                } header: {
                    Text("Current stored items: \(relatedItems.count)")
                }
            }
        }
    }
}
