//
//  ProductEditView.swift
//  Check your food
//
//  Created by Pascal Sauer on 01.05.25.
//

import SwiftUI

struct ProductEditView: View {
    @Bindable var product: ProductModel

    var body: some View {
        Form {
            Section {
                ProductImage(product: product)
                TextField("Product name", text: $product.productName)
            }
        }
    }
}
