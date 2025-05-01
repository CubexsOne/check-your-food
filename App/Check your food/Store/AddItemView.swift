//
//  AddItemView.swift
//  Check your food
//
//  Created by Pascal Sauer on 01.05.25.
//

import SwiftData
import SwiftUI

struct AddItemView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var selectedDate: Date = Calendar.current.startOfDay(for: Date())
    @Binding var isShowingScanSheet: Bool
    
    let searchedProduct: ProductModel
    
    var languageCode = Locale.current.language.languageCode?.identifier
    
    var body: some View {
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
            Spacer()
            Button("Cancel", role: .cancel) {
                isShowingScanSheet.toggle()
            }
            Spacer()
            Spacer()
            Button("Save") {
                let item = StoreItemModel(bestBefore: selectedDate, product: searchedProduct)
                modelContext.insert(item)
                isShowingScanSheet.toggle()
            }
            Spacer()
        }
        .padding(32)
    }
}
