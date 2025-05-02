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
    
    var body: some View {
        NavigationStack {
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
            .navigationTitle("Groceries")
        }
        .tabItem {
            Label("Stored Items", systemImage: "bag")
        }
        .tag(TabTags.storeItemList)
    }
}
