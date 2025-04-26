//
//  is-product-existing.swift
//  Check your food
//
//  Created by Pascal Sauer on 22.04.25.
//

import SwiftData
import SwiftUI

func getProductBy(barcode: String, _ modelContext: ModelContext) -> ProductModel? {
    let descriptor = FetchDescriptor<ProductModel>(
        predicate: #Predicate { $0.barcode == barcode }
    )
    
    do {
        let results = try modelContext.fetch(descriptor)
        return results.isEmpty ? nil : results.first
    } catch {
        print("Error fetching products: \(error.localizedDescription)")
        return nil
    }
}
