//
//  ProductImage.swift
//  Check your food
//
//  Created by Pascal Sauer on 26.04.25.
//

import SwiftUI

struct ProductImage: View {
    var product: ProductModel

    var body: some View {
        if let data = product.image, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 256, alignment: .center)
        } else {
            emptyImage()
                .frame(maxWidth: .infinity, maxHeight: 256, alignment: .center)
        }
    }
    
    func emptyImage() -> some View {
        return Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .foregroundColor(.gray)
            .opacity(0.3)
    }
}
