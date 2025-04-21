//
//  request-product-by-barcode.swift
//  Check your food
//
//  Created by Pascal Sauer on 21.04.25.
//

import SwiftUI

func requestProductBy(barcode: String) async -> (ProductDto?, Error?) {
    guard let url = URL(string: "https://world.openfoodfacts.org/api/v3/product/\(barcode).json") else { return (nil, URLError(.badURL)) }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    do {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // TODO: Handle HTTP Errors
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            throw NSError(domain: "", code: httpResponse.statusCode, userInfo: [
                NSLocalizedDescriptionKey: "Serverfehler: HTTP \(httpResponse.statusCode)"
            ])
        }
        
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(ProductDto.self, from: data)
        print(String(describing: decodedData))
        return (decodedData, nil)
    } catch {
        print("Error: \(error.localizedDescription)")
        return (nil, error)
    }
}
