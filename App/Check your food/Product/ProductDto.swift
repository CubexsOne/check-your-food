//
//  ProductDto.swift
//  Check your food
//
//  Created by Pascal Sauer on 21.04.25.
//

import SwiftUI

struct ProductDto: Codable {
    let barcode: String
    let product: OFFProductDto
    
    enum CodingKeys: String, CodingKey {
        case barcode = "code"
        case product = "product"
    }
}

struct OFFProductDto: Codable {
    let imageUrl: URL
    let productName: String
    
    enum CodingKeys: String, CodingKey {
        case productName = "product_name_en"
        case imageUrl = "image_url"
    }
}
