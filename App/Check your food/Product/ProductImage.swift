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
        AsyncImage(url: product.imageURL) { phase in
            switch phase {
            case .empty:
                emptyImage()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure(_):
                Image(systemName: "xmark.octagon")
            @unknown default:
                emptyImage()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 256, alignment: .center)
    }
    
    func emptyImage() -> some View {
        return Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .foregroundColor(.gray)
            .opacity(0.3)
    }
}
