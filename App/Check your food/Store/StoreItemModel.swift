//
//  StoreItem.swift
//  Check your food
//
//  Created by Pascal Sauer on 21.04.25.
//

import SwiftData
import SwiftUI

@Model
class StoreItemModel: Identifiable {
    var id: UUID
    var bestBefore: Date
    var isDeleted: Bool = false
    @Relationship() var product: ProductModel
    
    init(bestBefore: Date, product: ProductModel) {
        self.id = UUID()
        self.bestBefore = bestBefore
        self.product = product
    }
}
