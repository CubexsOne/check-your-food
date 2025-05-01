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
    var productName: String
    var image: Data?
    
    init(barcode: String, productName: String, image: Data?) {
        self.id = UUID()
        self.barcode = barcode
        self.productName = productName
        self.image = image
    }
}

func mapDtoToModel(dto: ProductDto, image: Data?) -> ProductModel {
    return ProductModel(
        barcode: dto.barcode,
        productName: dto.product.productName,
        image: image
    )
}
