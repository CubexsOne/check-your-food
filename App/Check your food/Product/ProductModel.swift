//
//  ProductModel.swift
//  Check your food
//
//  Created by Pascal Sauer on 21.04.25.
//

import SwiftData
import SwiftUI

@Model
class ProductModel {
    var id: UUID
    var barcode: String
    var productNameDE: String
    var productNameEN: String
    var imageURL: URL
    
    init(barcode: String, productNameDE: String, productNameEN: String, imageURL: URL) {
        self.id = UUID()
        self.barcode = barcode
        self.productNameDE = productNameDE
        self.productNameEN = productNameEN
        self.imageURL = imageURL
    }
}

func mapDtoToModel(_ dto: ProductDto) -> ProductModel {
    return ProductModel(
        barcode: dto.barcode,
        productNameDE: dto.product.productNameDE,
        productNameEN: dto.product.productNameEN,
        imageURL: dto.product.imageUrl
    )
}
