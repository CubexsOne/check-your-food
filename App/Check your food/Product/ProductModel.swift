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
    var image: Data?
    
    init(barcode: String, productNameDE: String, productNameEN: String, image: Data?) {
        self.id = UUID()
        self.barcode = barcode
        self.productNameDE = productNameDE
        self.productNameEN = productNameEN
        self.image = image
    }
}

func mapDtoToModel(dto: ProductDto, image: Data?) -> ProductModel {
    return ProductModel(
        barcode: dto.barcode,
        productNameDE: dto.product.productNameDE,
        productNameEN: dto.product.productNameEN,
        image: image
    )
}
